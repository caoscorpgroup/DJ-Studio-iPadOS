import XCTest
@testable import DJStudioCore

final class MP3ID3RealFileFixtureTests: XCTestCase {
    /// Exercises FileHandle parsing against a binary file written to disk.
    /// The fixture contains valid ID3v2.3 bytes and an MPEG sync-like payload;
    /// it is not a commercial recording or a full decodable MP3 sample.
    func testReadsTagsFromTemporaryMP3File() async throws {
        let title = Data([0x03]) + Data("Night Drive".utf8)
        let frame = Data("TIT2".utf8)
            + Data([0, 0, 0, UInt8(title.count), 0, 0])
            + title
        let tagSize = frame.count
        let header = Data([
            0x49, 0x44, 0x33, 0x03, 0x00, 0x00,
            0x00, 0x00, 0x00, UInt8(tagSize)
        ])
        let mpegLikePayload = Data([0xFF, 0xFB, 0x90, 0x64]) + Data(repeating: 0, count: 128)
        let fileData = header + frame + mpegLikePayload

        let fileURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("mp3")
        defer { try? FileManager.default.removeItem(at: fileURL) }
        try fileData.write(to: fileURL)

        let metadata = try await MP3ID3Reader().readMetadata(from: fileURL)
        XCTAssertEqual(metadata.title, "Night Drive")
    }
}
