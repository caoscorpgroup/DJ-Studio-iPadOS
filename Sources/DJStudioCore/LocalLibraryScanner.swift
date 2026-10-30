import Foundation

/// Connects folder discovery, metadata reading, optional duration reading,
/// optional local analysis and persistent storage. Work is sequential by design.
public struct LocalLibraryScanner: Sendable {
    private let metadataReader: any AudioMetadataReading
    private let analyzer: (any LocalMusicAnalyzing)?

    public init(
        metadataReader: any AudioMetadataReading = MP3ID3Reader(),
        analyzer: (any LocalMusicAnalyzing)? = nil
    ) {
        self.metadataReader = metadataReader
        self.analyzer = analyzer
    }

    public func scan(files: [URL], into store: LocalLibraryStore) async throws -> [Track] {
        let existingTracks = await store.allTracks()
        let existingByPath = existingTracks.reduce(into: [String: Track]()) { result, track in
            result[track.fileURL.standardizedFileURL.path] = track
        }
        var imported: [Track] = []
        imported.reserveCapacity(files.count)

        for fileURL in files {
            let path = fileURL.standardizedFileURL.path
            let previous = existingByPath[path]
            // Keep files even when a format has no readable embedded metadata.
            let metadata = (try? await metadataReader.readMetadata(from: fileURL)) ?? TrackMetadata()

            let duration: TimeInterval?
            if let durationReader = metadataReader as? any AudioDurationReading {
                duration = (try? await durationReader.duration(of: fileURL)) ?? previous?.duration
            } else {
                duration = previous?.duration
            }

            let analysis: TrackAnalysis
            if let analyzer {
                analysis = (try? await analyzer.analyze(fileURL: fileURL)) ?? previous?.analysis ?? TrackAnalysis()
            } else {
                analysis = previous?.analysis ?? TrackAnalysis()
            }

            imported.append(Track(
                id: previous?.id ?? UUID(),
                fileURL: fileURL,
                fileBookmark: previous?.fileBookmark,
                duration: duration,
                metadata: metadata,
                analysis: analysis
            ))
        }

        try await store.upsert(contentsOf: imported)
        return imported
    }
}
