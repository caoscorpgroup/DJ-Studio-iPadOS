import XCTest
@testable import DJStudioCore

final class MP3ID3ReaderTests: XCTestCase {
    func testReadsCommonID3v23TextFramesAndBPM() async throws {
        let frames = [
            frame("TIT2", text("Night Drive")),
            frame("TPE1", text("Example Artist")),
            frame("TALB", text("After Hours")),
            frame("TCON", text("Techno")),
            frame("TBPM", text("128.5")),
            frame("TKEY", text("Am"))
        ].reduce(into: Data()) { $0.append($1) }

        var tag = Data("ID3".utf8)
        tag.append(contentsOf: [3, 0, 0])
        tag.append(syncSafe(frames.count))
        tag.append(frames)

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("mp3")
        try tag.write(to: url)
        defer { try? FileManager.default.removeItem(at: url) }

        let metadata = try await MP3ID3Reader().readMetadata(from: url)
        XCTAssertEqual(metadata.title, "Night Drive")
        XCTAssertEqual(metadata.artist, "Example Artist")
        XCTAssertEqual(metadata.album, "After Hours")
        XCTAssertEqual(metadata.genre, "Techno")
        XCTAssertEqual(metadata.bpm, 128.5)
        XCTAssertEqual(metadata.musicalKey, "Am")
    }

    private func text(_ value: String) -> Data {
        var data = Data([3]) // UTF-8 text encoding
        data.append(Data(value.utf8))
        return data
    }

    private func frame(_ id: String, _ payload: Data) -> Data {
        var data = Data(id.utf8)
        let size = UInt32(payload.count)
        data.append(contentsOf: [
            UInt8((size >> 24) & 0xFF),
            UInt8((size >> 16) & 0xFF),
            UInt8((size >> 8) & 0xFF),
            UInt8(size & 0xFF),
            0, 0
        ])
        data.append(payload)
        return data
    }

    private func syncSafe(_ value: Int) -> [UInt8] {
        [
            UInt8((value >> 21) & 0x7F),
            UInt8((value >> 14) & 0x7F),
            UInt8((value >> 7) & 0x7F),
            UInt8(value & 0x7F)
        ]
    }
}
