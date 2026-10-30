#if os(iOS)
import SwiftUI
import UniformTypeIdentifiers

/// First iPadOS library screen. Folder access is always initiated by the user.
@MainActor
public struct MusicLibraryView: View {
    @State private var folders: [MusicFolderBookmark] = []
    @State private var tracks: [Track] = []
    @State private var searchText = ""
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
                                    if let bpm = track.metadata.bpm { Text(String(format: "%.1f BPM", bpm)) }
                                    if let key = track.metadata.musicalKey { Text(key) }
                                    if let duration = track.duration { Text(Self.durationLabel(duration)) }
                                    Text(track.fileURL.pathExtension.uppercased())
                                }
                                .font(.caption.monospacedDigit())
                                .foregroundStyle(.secondary)
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
        guard !query.isEmpty else { return tracks }
        return tracks.filter { track in
            [track.metadata.title, track.metadata.artist, track.metadata.album, track.fileURL.lastPathComponent]
                .compactMap { $0 }
                .contains { $0.localizedCaseInsensitiveContains(query) }
        }
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
#endif
