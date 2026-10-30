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
            imported.append(Track(fileURL: fileURL, metadata: metadata, analysis: analysis))
        }

        try await store.upsert(contentsOf: imported)
        return imported
    }
}
