import Foundation

/// Small JSON-backed local catalog. It stores references and analysis results,
/// not copies of the user's music files.
public actor LocalLibraryStore {
    private let catalogURL: URL
    private var tracksByID: [UUID: Track] = [:]

    public init(catalogURL: URL) {
        self.catalogURL = catalogURL
    }

    public func load() throws -> [Track] {
        guard FileManager.default.fileExists(atPath: catalogURL.path) else {
            tracksByID = [:]
            return []
        }
        let data = try Data(contentsOf: catalogURL)
        let tracks = try JSONDecoder().decode([Track].self, from: data)
        tracksByID = Dictionary(uniqueKeysWithValues: tracks.map { ($0.id, $0) })
        return sortedTracks()
    }

    @discardableResult
    public func upsert(_ track: Track) throws -> Track {
        tracksByID[track.id] = track
        try persist()
        return track
    }

    public func upsert(contentsOf tracks: [Track]) throws {
        for track in tracks {
            tracksByID[track.id] = track
        }
        try persist()
    }

    public func remove(_ id: UUID) throws {
        tracksByID.removeValue(forKey: id)
        try persist()
    }

    public func allTracks() -> [Track] {
        sortedTracks()
    }

    private func sortedTracks() -> [Track] {
        tracksByID.values.sorted {
            let left = $0.metadata.title ?? $0.fileURL.lastPathComponent
            let right = $1.metadata.title ?? $1.fileURL.lastPathComponent
            return left.localizedStandardCompare(right) == .orderedAscending
        }
    }

    private func persist() throws {
        let directory = catalogURL.deletingLastPathComponent()
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let data = try JSONEncoder().encode(sortedTracks())
        try data.write(to: catalogURL, options: [.atomic])
    }
}
