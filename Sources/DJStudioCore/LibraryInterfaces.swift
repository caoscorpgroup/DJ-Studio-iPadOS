import Foundation

/// Adapters in the iPadOS app implement these interfaces using system APIs.
/// The core deliberately has no network or file-system side effects.
public protocol AudioMetadataReading: Sendable {
    func readMetadata(from fileURL: URL) async throws -> TrackMetadata
}

public protocol LocalMusicAnalyzing: Sendable {
    func analyze(fileURL: URL) async throws -> TrackAnalysis
}

/// Optional duration capability implemented by readers backed by media frameworks.
public protocol AudioDurationReading: Sendable {
    func duration(of fileURL: URL) async throws -> TimeInterval?
}

/// Optional metadata enrichment. The default app configuration can omit this
/// dependency entirely; library analysis and recommendations remain offline.
public protocol ExternalMetadataEnriching: Sendable {
    func enrich(metadata: TrackMetadata, for fileURL: URL) async throws -> TrackMetadata
}

public enum LibraryImportError: Error, Equatable {
    case unsupportedFileType
    case metadataReadFailed
    case analysisFailed
}
