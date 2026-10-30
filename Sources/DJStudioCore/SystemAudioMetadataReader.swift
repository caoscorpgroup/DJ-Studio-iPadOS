import Foundation
import AVFoundation

/// Reads common embedded metadata using AVFoundation for audio formats supported
/// by the OS. MP3 ID3 values are used as a fallback when common metadata is absent.
/// No network access and no writes to source files occur.
public struct SystemAudioMetadataReader: AudioMetadataReading {
    private let mp3Reader = MP3ID3Reader()

    public init() {}

    public func readMetadata(from fileURL: URL) async throws -> TrackMetadata {
        let asset = AVURLAsset(url: fileURL)
        let items = try await asset.load(.commonMetadata)
        var metadata = TrackMetadata()

        for item in items {
            guard let value = try? await item.load(.stringValue), let value, !value.isEmpty else { continue }
            switch item.commonKey {
            case .commonKeyTitle: metadata.title = value
            case .commonKeyArtist: metadata.artist = value
            case .commonKeyAlbumName: metadata.album = value
            case .commonKeyType: metadata.genre = value
            default: break
            }
        }

        if fileURL.pathExtension.lowercased() == "mp3" {
            let id3 = (try? await mp3Reader.readMetadata(from: fileURL)) ?? TrackMetadata()
            metadata.title = metadata.title ?? id3.title
            metadata.artist = metadata.artist ?? id3.artist
            metadata.album = metadata.album ?? id3.album
            metadata.year = metadata.year ?? id3.year
            metadata.genre = metadata.genre ?? id3.genre
            metadata.label = id3.label
            metadata.bpm = id3.bpm
            metadata.musicalKey = id3.musicalKey
        }
        return metadata
    }

    public func duration(of fileURL: URL) async throws -> TimeInterval? {
        let asset = AVURLAsset(url: fileURL)
        let time = try await asset.load(.duration)
        let seconds = CMTimeGetSeconds(time)
        return seconds.isFinite && seconds >= 0 ? seconds : nil
    }
}
