import XCTest
@testable import DJStudioCore

final class LocalLibraryStoreTests: XCTestCase {
    func testCatalogPersistsTracksAndMetadata() async throws {
        let directory = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        let catalog = directory.appendingPathComponent("library.json")
        let store = LocalLibraryStore(catalogURL: catalog)
        let track = Track(
            fileURL: directory.appendingPathComponent("track.mp3"),
            metadata: TrackMetadata(title: "Local Track", artist: "Local Artist", bpm: 126)
        )

        try await store.upsert(track)
        let reopenedStore = LocalLibraryStore(catalogURL: catalog)
        let loaded = try await reopenedStore.load()

        XCTAssertEqual(loaded.count, 1)
        XCTAssertEqual(loaded.first?.id, track.id)
        XCTAssertEqual(loaded.first?.metadata.title, "Local Track")
        XCTAssertEqual(loaded.first?.metadata.bpm, 126)
    }
}
