import XCTest
@testable import DJStudioCore

final class LocalFolderImporterTests: XCTestCase {
    func testSupportedAudioExtensionsIncludeCommonLocalFormats() {
        XCTAssertTrue(SupportedAudioFile.extensions.contains("mp3"))
        XCTAssertTrue(SupportedAudioFile.extensions.contains("m4a"))
        XCTAssertTrue(SupportedAudioFile.extensions.contains("wav"))
    }

    func testImporterRejectsMissingDirectory() {
        let importer = LocalFolderImporter()
        let missing = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        XCTAssertThrowsError(try importer.audioFiles(in: missing))
    }
}
