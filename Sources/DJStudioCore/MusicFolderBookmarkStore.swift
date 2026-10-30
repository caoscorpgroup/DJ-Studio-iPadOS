import Foundation

/// Persists user-granted folder access. The app must call startAccessingSecurityScopedResource()
/// before enumerating a resolved URL and stopAccessingSecurityScopedResource() afterwards.
public struct MusicFolderBookmark: Codable, Equatable, Identifiable, Sendable {
    public let id: UUID
    public let displayName: String
    public var bookmarkData: Data

    public init(id: UUID = UUID(), displayName: String, bookmarkData: Data) {
        self.id = id
        self.displayName = displayName
        self.bookmarkData = bookmarkData
    }
}

public enum MusicFolderBookmarkError: Error {
    case staleBookmark
}

/// Stores bookmarks in the app's private Application Support directory, not in iCloud.
public actor MusicFolderBookmarkStore {
    private let storageURL: URL

    public init(storageURL: URL) {
        self.storageURL = storageURL
    }

    public func load() throws -> [MusicFolderBookmark] {
        guard FileManager.default.fileExists(atPath: storageURL.path) else { return [] }
        return try JSONDecoder().decode([MusicFolderBookmark].self, from: Data(contentsOf: storageURL))
    }

    @discardableResult
    public func add(folderURL: URL) throws -> MusicFolderBookmark {
        let data = try folderURL.bookmarkData(
            options: [],
            includingResourceValuesForKeys: nil,
            relativeTo: nil
        )
        let item = MusicFolderBookmark(displayName: folderURL.lastPathComponent, bookmarkData: data)
        var items = try load()
        items.removeAll { $0.displayName == item.displayName && $0.bookmarkData == item.bookmarkData }
        items.append(item)
        try persist(items)
        return item
    }

    /// Resolve immediately before access; callers still need to bracket use with
    /// startAccessingSecurityScopedResource()/stopAccessingSecurityScopedResource().
    public func resolve(_ bookmark: MusicFolderBookmark) throws -> (url: URL, isStale: Bool) {
        var isStale = false
        let url = try URL(
            resolvingBookmarkData: bookmark.bookmarkData,
            options: [],
            relativeTo: nil,
            bookmarkDataIsStale: &isStale
        )
        return (url, isStale)
    }

    public func remove(_ id: UUID) throws {
        var items = try load()
        items.removeAll { $0.id == id }
        try persist(items)
    }

    private func persist(_ items: [MusicFolderBookmark]) throws {
        try FileManager.default.createDirectory(
            at: storageURL.deletingLastPathComponent(),
            withIntermediateDirectories: true
        )
        try JSONEncoder().encode(items).write(to: storageURL, options: [.atomic])
    }
}
