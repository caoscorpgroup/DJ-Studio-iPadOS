import XCTest
@testable import DJStudioCore

final class LocalLibraryScannerTests: XCTestCase {
    func testRescanningSameFileUpdatesExistingTrackInsteadOfDuplicating() async throws {
        let directory = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let file = directory.appendingPathComponent("same-track.mp3")
        try Data().write(to: file)

        let store = LocalLibraryStore(catalogURL: directory.appendingPathComponent("library.json"))
        let scanner = LocalLibraryScanner(metadataReader: StubMetadataReader())
        let first = try await scanner.scan(files: [file], into: store)
        let second = try await scanner.scan(files: [file], into: store)
        let allTracks = await store.allTracks()

        XCTAssertEqual(first.first?.id, second.first?.id)
        XCTAssertEqual(allTracks.count, 1)
    }

    func testScannerStoresDurationWhenReaderProvidesIt() async throws {
        let directory = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let file = directory.appendingPathComponent("duration-track.m4a")
        try Data().write(to: file)

        let store = LocalLibraryStore(catalogURL: directory.appendingPathComponent("library.json"))
        let scanner = LocalLibraryScanner(metadataReader: StubMetadataReader())
        let imported = try await scanner.scan(files: [file], into: store)

        XCTAssertEqual(imported.first?.duration, 214.5)
    }
}

private struct StubMetadataReader: AudioMetadataReading, AudioDurationReading {
    func readMetadata(from fileURL: URL) async throws -> TrackMetadata {
        TrackMetadata(title: fileURL.deletingPathExtension().lastPathComponent)
    }

    func duration(of fileURL: URL) async throws -> TimeInterval? {
        214.5
    }
}
