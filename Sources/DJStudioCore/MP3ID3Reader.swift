import Foundation

/// Reads common ID3v2.2/v2.3/v2.4 text frames and ID3v1 fallback tags.
/// This parser only reads tags; it never edits or rewrites the audio file.
public struct MP3ID3Reader: AudioMetadataReading {
    public init() {}

    public func readMetadata(from fileURL: URL) async throws -> TrackMetadata {
        let handle = try FileHandle(forReadingFrom: fileURL)
        defer { try? handle.close() }

        let fileSize = try handle.seekToEnd()
        try handle.seek(toOffset: 0)
        let header = try handle.read(upToCount: 10) ?? Data()

        guard header.count >= 3,
              String(data: header.prefix(3), encoding: .ascii) == "ID3" else {
            return readID3v1Tail(from: handle, fileSize: fileSize) ?? TrackMetadata()
        }
        guard header.count == 10 else {
            return readID3v1Tail(from: handle, fileSize: fileSize) ?? TrackMetadata()
        }

        let majorVersion = header[3]
        guard (2...4).contains(majorVersion) else {
            return readID3v1Tail(from: handle, fileSize: fileSize) ?? TrackMetadata()
        }

        let tagSize = synchsafeInteger(header, at: 6)
        guard tagSize >= 0, tagSize <= 16 * 1024 * 1024, UInt64(tagSize) <= fileSize - 10 else {
            return readID3v1Tail(from: handle, fileSize: fileSize) ?? TrackMetadata()
        }

        let tagData = try handle.read(upToCount: tagSize) ?? Data()
        guard tagData.count == tagSize else {
            return readID3v1Tail(from: handle, fileSize: fileSize) ?? TrackMetadata()
        }

        let unsynchronized = (header[5] & 0x80) != 0
        let normalizedTag = unsynchronized ? removeUnsynchronization(from: tagData) : tagData
        var metadata = TrackMetadata()
        parseFrames(in: normalizedTag, version: majorVersion, into: &metadata)
        return merge(metadata, fallback: readID3v1Tail(from: handle, fileSize: fileSize))
    }

    private func readID3v1Tail(from handle: FileHandle, fileSize: UInt64) -> TrackMetadata? {
        guard fileSize >= 128 else { return nil }
        do {
            try handle.seek(toOffset: fileSize - 128)
            let tail = try handle.read(upToCount: 128) ?? Data()
            return tail.count == 128 ? readID3v1(from: tail) : nil
        } catch {
            return nil
        }
    }

    private func parseFrames(in data: Data, version: UInt8, into metadata: inout TrackMetadata) {
        var offset = 0
        let headerLength = version == 2 ? 6 : 10

        while offset + headerLength <= data.count {
            let identifierLength = version == 2 ? 3 : 4
            let identifierData = data[offset..<(offset + identifierLength)]
            guard let identifier = String(data: identifierData, encoding: .ascii),
                  identifier.utf8.allSatisfy { (65...90).contains($0) || (48...57).contains($0) } else { break }

            if identifier.allSatisfy({ $0 == "\0" }) { break }

            let frameSize: Int
            if version == 2 {
                frameSize = (Int(data[offset + 3]) << 16)
                    | (Int(data[offset + 4]) << 8)
                    | Int(data[offset + 5])
            } else if version == 4 {
                frameSize = synchsafeInteger(data, at: offset + 4)
            } else {
                frameSize = (Int(data[offset + 4]) << 24)
                    | (Int(data[offset + 5]) << 16)
                    | (Int(data[offset + 6]) << 8)
                    | Int(data[offset + 7])
            }

            guard frameSize >= 0 else { break }
            let frameStart = offset + headerLength
            let frameEnd = frameStart + frameSize
            guard frameEnd <= data.count else { break }

            // Skip compressed/encrypted frames; their payload is not plain text.
            let isUnsupportedFormat: Bool
            if version == 2 {
                isUnsupportedFormat = false
            } else {
                let formatFlags = data[offset + 9]
                isUnsupportedFormat = (formatFlags & 0x0C) != 0
            }

            if !isUnsupportedFormat, frameSize > 0 {
                let payload = data[frameStart..<frameEnd]
                applyFrame(identifier, payload: Data(payload), version: version, to: &metadata)
            }
            offset = frameEnd
        }
    }

    private func applyFrame(_ id: String, payload: Data, version: UInt8, to metadata: inout TrackMetadata) {
        guard let value = decodeTextFrame(payload) else { return }
        switch id {
        case "TIT2", "TT2": metadata.title = value
        case "TPE1", "TP1": metadata.artist = value
        case "TALB", "TAL": metadata.album = value
        case "TDRC", "TYER", "TYE":
            metadata.year = firstYear(in: value)
        case "TCON", "TCO": metadata.genre = value
        case "TPUB", "TPB": metadata.label = value
        case "TBPM", "TBP":
            metadata.bpm = Double(value.replacingOccurrences(of: ",", with: "."))
        case "TKEY", "TKE": metadata.musicalKey = value
        default: break
        }
    }

    private func decodeTextFrame(_ payload: Data) -> String? {
        guard let encodingByte = payload.first else { return nil }
        let textData = payload.dropFirst()
        let encoding: String.Encoding
        switch encodingByte {
        case 0: encoding = .isoLatin1
        case 1: encoding = .utf16
        case 2: encoding = .utf16BigEndian
        case 3: encoding = .utf8
        default: return nil
        }
        guard let decoded = String(data: Data(textData), encoding: encoding) else { return nil }
        let cleaned = decoded
            .replacingOccurrences(of: "\0", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        return cleaned.isEmpty ? nil : cleaned
    }

    private func readID3v1(from data: Data) -> TrackMetadata? {
        guard data.count >= 128 else { return nil }
        let start = data.count - 128
        guard String(data: data[start..<(start + 3)], encoding: .ascii) == "TAG" else { return nil }

        func field(_ range: Range<Int>) -> String? {
            let bytes = data[(start + range.lowerBound)..<(start + range.upperBound)]
            guard let value = String(data: bytes, encoding: .isoLatin1) else { return nil }
            let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines.union(CharacterSet(charactersIn: "\0")))
            return trimmed.isEmpty ? nil : trimmed
        }

        let year = field(93..<97).flatMap(firstYear)
        return TrackMetadata(
            title: field(3..<33),
            artist: field(33..<63),
            album: field(63..<93),
            year: year,
            genre: data[start + 127] == 255 ? nil : "ID3v1 genre code \(data[start + 127])"
        )
    }

    private func merge(_ primary: TrackMetadata, fallback: TrackMetadata?) -> TrackMetadata {
        guard let fallback else { return primary }
        var result = primary
        result.title = result.title ?? fallback.title
        result.artist = result.artist ?? fallback.artist
        result.album = result.album ?? fallback.album
        result.year = result.year ?? fallback.year
        result.genre = result.genre ?? fallback.genre
        return result
    }

    private func firstYear(in value: String) -> Int? {
        let digits = value.prefix(while: { $0.isNumber })
        return Int(digits)
    }

    private func synchsafeInteger(_ data: Data, at offset: Int) -> Int {
        guard offset >= 0, offset + 4 <= data.count else { return -1 }
        return (Int(data[offset] & 0x7F) << 21)
            | (Int(data[offset + 1] & 0x7F) << 14)
            | (Int(data[offset + 2] & 0x7F) << 7)
            | Int(data[offset + 3] & 0x7F)
    }

    private func removeUnsynchronization(from data: Data) -> Data {
        var output = Data()
        output.reserveCapacity(data.count)
        var index = 0
        while index < data.count {
            output.append(data[index])
            if data[index] == 0xFF,
               index + 1 < data.count,
               data[index + 1] == 0x00 {
                index += 1
            }
            index += 1
        }
        return output
    }
}
