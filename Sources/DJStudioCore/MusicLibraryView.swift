#if os(iOS)
import SwiftUI
import UniformTypeIdentifiers

/// First iPadOS library screen. Folder access is always initiated by the user.
@MainActor
public struct MusicLibraryView: View {
    @State private var folders: [MusicFolderBookmark] = []
    @State private var tracks: [Track] = []
    @State private var searchText = ""
    @State private var sortOption: LibrarySortOption = .title
    @State private var minimumBPM = 0.0
    @State private var maximumBPM = 250.0
    @State private var keyFilter = ""
    @State private var deckATrackID: UUID?
    @State private var deckBTrackID: UUID?
    @State private var isChoosingFolder = false
    @State private var isScanning = false
    @State private var message = "Selecciona una carpeta de música para comenzar."

    private let folderStore: MusicFolderBookmarkStore
    private let libraryStore: LocalLibraryStore
    private let importer = LocalFolderImporter()
    private let scanner = LocalLibraryScanner(metadataReader: SystemAudioMetadataReader())

    public init() {
        let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        let appDirectory = support.appendingPathComponent("DJStudio", isDirectory: true)
        folderStore = MusicFolderBookmarkStore(storageURL: appDirectory.appendingPathComponent("music-folders.json"))
        libraryStore = LocalLibraryStore(catalogURL: appDirectory.appendingPathComponent("library.json"))
    }

    public var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        isChoosingFolder = true
                    } label: {
                        Label("Añadir carpeta", systemImage: "folder.badge.plus")
                    }
                    .disabled(isScanning)

                    if isScanning {
                        ProgressView("Analizando archivos…")
                    }
                    Text(message)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                if !folders.isEmpty {
                    Section("Carpetas autorizadas") {
                        ForEach(folders) { folder in
                            HStack {
                                Label(folder.displayName, systemImage: "folder")
                                Spacer()
                                Button("Escanear") { Task { await scan(folder) } }
                                    .disabled(isScanning)
                            }
                        }
                    }
                }

                Section("Biblioteca · \(tracks.count)") {
                    if !tracks.isEmpty {
                        Picker("Ordenar por", selection: $sortOption) {
                            ForEach(LibrarySortOption.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(.menu)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Rango BPM: \(Int(minimumBPM))–\(Int(maximumBPM))")
                                .font(.subheadline)
                            Slider(value: $minimumBPM, in: 0...250, step: 1)
                            Slider(value: $maximumBPM, in: 0...250, step: 1)
                            HStack {
                                Text("Tonalidad / Camelot")
                                Spacer()
                                TextField("Ej. 8A", text: $keyFilter)
                                    .textInputAutocapitalization(.characters)
                                    .autocorrectionDisabled()
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxWidth: 100)
                            }
                            Button("Restablecer filtros") {
                                minimumBPM = 0
                                maximumBPM = 250
                                keyFilter = ""
                            }
                            .font(.caption)
                        }
                        .padding(.vertical, 4)

                        HStack {
                            Label(deckATrackID == nil ? "Deck A sin preparar" : "Deck A preparado", systemImage: "a.circle")
                            Spacer()
                            Label(deckBTrackID == nil ? "Deck B sin preparar" : "Deck B preparado", systemImage: "b.circle")
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                    if tracks.isEmpty {
                        ContentUnavailableView("Biblioteca vacía", systemImage: "music.note.list",
                                               description: Text("Añade una carpeta con archivos de audio."))
                    } else {
                        ForEach(filteredTracks) { track in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(track.metadata.title ?? track.fileURL.deletingPathExtension().lastPathComponent)
                                    .font(.headline)
                                Text([track.metadata.artist, track.metadata.album].compactMap { $0 }.joined(separator: " · "))
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                HStack(spacing: 12) {
                                    if let bpm = track.analysis.bpm ?? track.metadata.bpm { Text(String(format: "%.1f BPM", bpm)) }
                                    if let key = track.analysis.camelotKey ?? track.metadata.musicalKey { Text(key) }
                                    if let duration = track.duration { Text(Self.durationLabel(duration)) }
                                    Text(track.fileURL.pathExtension.uppercased())
                                }
                                .font(.caption.monospacedDigit())
                                .foregroundStyle(.secondary)
                                Menu("Preparar en deck") {
                                    Button("Deck A") { deckATrackID = track.id }
                                    Button("Deck B") { deckBTrackID = track.id }
                                }
                                .font(.caption)
                                if deckATrackID == track.id {
                                    Text("Preparada para Deck A").font(.caption2).foregroundStyle(.tint)
                                }
                                if deckBTrackID == track.id {
                                    Text("Preparada para Deck B").font(.caption2).foregroundStyle(.tint)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Biblioteca musical")
            .searchable(text: $searchText, prompt: "Buscar pista, artista o álbum")
            .fileImporter(isPresented: $isChoosingFolder, allowedContentTypes: [.folder],
                          allowsMultipleSelection: true, onCompletion: handleFolderSelection)
            .task { await reload() }
        }
        .preferredColorScheme(.dark)
    }

    private var filteredTracks: [Track] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        let matches = tracks.filter { track in
            let textMatches = query.isEmpty || [track.metadata.title, track.metadata.artist, track.metadata.album, track.fileURL.lastPathComponent]
                .compactMap { $0 }
                .contains { $0.localizedCaseInsensitiveContains(query) }
            let bpm = track.analysis.bpm ?? track.metadata.bpm
            let lowerBPM = min(minimumBPM, maximumBPM)
            let upperBPM = max(minimumBPM, maximumBPM)
            let bpmMatches = bpm.map { $0 >= lowerBPM && $0 <= upperBPM } ?? (lowerBPM == 0 && upperBPM == 250)
            let keyQuery = keyFilter.trimmingCharacters(in: .whitespacesAndNewlines)
            let key = track.analysis.camelotKey ?? track.metadata.musicalKey ?? ""
            let keyMatches = keyQuery.isEmpty || key.localizedCaseInsensitiveContains(keyQuery)
            return textMatches && bpmMatches && keyMatches
        }
        return matches.sorted { left, right in
            switch sortOption {
            case .title:
                return displayTitle(left).localizedStandardCompare(displayTitle(right)) == .orderedAscending
            case .artist:
                return (left.metadata.artist ?? "").localizedStandardCompare(right.metadata.artist ?? "") == .orderedAscending
            case .bpm:
                return (left.analysis.bpm ?? left.metadata.bpm ?? .greatestFiniteMagnitude) <
                    (right.analysis.bpm ?? right.metadata.bpm ?? .greatestFiniteMagnitude)
            case .key:
                return (left.analysis.camelotKey ?? left.metadata.musicalKey ?? "ZZZ")
                    .localizedStandardCompare(right.analysis.camelotKey ?? right.metadata.musicalKey ?? "ZZZ") == .orderedAscending
            case .duration:
                return (left.duration ?? .greatestFiniteMagnitude) < (right.duration ?? .greatestFiniteMagnitude)
            }
        }
    }

    private func displayTitle(_ track: Track) -> String {
        track.metadata.title ?? track.fileURL.deletingPathExtension().lastPathComponent
    }

    private static func durationLabel(_ duration: TimeInterval) -> String {
        let totalSeconds = max(0, Int(duration.rounded()))
        return String(format: "%d:%02d", totalSeconds / 60, totalSeconds % 60)
    }

    private func handleFolderSelection(_ result: Result<[URL], Error>) {
        Task {
            switch result {
            case .failure(let error):
                message = "No se pudo seleccionar la carpeta: \(error.localizedDescription)"
            case .success(let urls):
                for url in urls {
                    let didStart = url.startAccessingSecurityScopedResource()
                    defer { if didStart { url.stopAccessingSecurityScopedResource() } }
                    do {
                        _ = try await folderStore.add(folderURL: url)
                        try await scanURL(url)
                    } catch {
                        message = "Error al importar \(url.lastPathComponent): \(error.localizedDescription)"
                    }
                }
                await reload()
            }
        }
    }

    private func scan(_ folder: MusicFolderBookmark) async {
        do {
            let resolved = try await folderStore.resolve(folder)
            guard !resolved.isStale else {
                message = "El permiso de \(folder.displayName) caducó. Vuelve a seleccionarla."
                return
            }
            let didStart = resolved.url.startAccessingSecurityScopedResource()
            defer { if didStart { resolved.url.stopAccessingSecurityScopedResource() } }
            try await scanURL(resolved.url)
        } catch {
            message = "No se pudo abrir \(folder.displayName): \(error.localizedDescription)"
        }
    }

    private func scanURL(_ url: URL) async throws {
        isScanning = true
        defer { isScanning = false }
        let files = try importer.audioFiles(in: url)
        let imported = try await scanner.scan(files: files, into: libraryStore)
        tracks = await libraryStore.allTracks()
        message = "Escaneo terminado: \(imported.count) archivos encontrados."
    }

    private func reload() async {
        do {
            folders = try await folderStore.load()
            tracks = try await libraryStore.load()
        } catch {
            message = "No se pudo cargar la biblioteca: \(error.localizedDescription)"
        }
    }
}
private enum LibrarySortOption: String, CaseIterable, Identifiable {
    case title = "Título"
    case artist = "Artista"
    case bpm = "BPM"
    case key = "Tonalidad"
    case duration = "Duración"

    var id: String { rawValue }
}
#endif
