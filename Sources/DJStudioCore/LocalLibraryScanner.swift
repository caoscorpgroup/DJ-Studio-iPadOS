import Foundation

/// Connects folder discovery, metadata reading, optional local analysis and
/// persistent storage. Work is sequential by design for predictable memory use.
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
        let existingByPath = Dictionary(
            uniqueKeysWithValues: existingTracks.map { ($0.fileURL.standardizedFileURL.path, $0) }
        )
        var imported: [Track] = []
        imported.reserveCapacity(files.count)

        for fileURL in files {
            let metadata = try await metadataReader.readMetadata(from: fileURL)
            let analysis: TrackAnalysis
            if let analyzer {
                analysis = (try? await analyzer.analyze(fileURL: fileURL)) ?? TrackAnalysis()
            } else {
                analysis = TrackAnalysis()
            }

            let previous = existingByPath[fileURL.standardizedFileURL.path]
            imported.append(Track(
                id: previous?.id ?? UUID(),
                fileURL: fileURL,
                fileBookmark: previous?.fileBookmark,
                duration: previous?.duration,
                metadata: metadata,
                analysis: analysis
            ))
        }

        try await store.upsert(contentsOf: imported)
        return imported
    }
}
