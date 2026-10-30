import Foundation

public struct TrackMetadata: Codable, Equatable, Sendable {
    public var title: String?
    public var artist: String?
    public var album: String?
    public var year: Int?
    public var genre: String?
    public var label: String?
    public var version: String?

    public init(
        title: String? = nil,
        artist: String? = nil,
        album: String? = nil,
        year: Int? = nil,
        genre: String? = nil,
        label: String? = nil,
        version: String? = nil
    ) {
        self.title = title
        self.artist = artist
        self.album = album
        self.year = year
        self.genre = genre
        self.label = label
        self.version = version
    }
}

public struct TrackAnalysis: Codable, Equatable, Sendable {
    /// Estimated beats per minute. This is an analysis result, not an ID3 field.
    public var bpm: Double?
    /// Camelot notation, for example "8A" or "9B".
    public var camelotKey: String?
    /// Normalized estimated energy in the range 0...1.
    public var energy: Double?
    public var beatGridOffset: TimeInterval?
    public var bpmConfidence: Double?
    public var keyConfidence: Double?
    public var energyConfidence: Double?

    public init(
        bpm: Double? = nil,
        camelotKey: String? = nil,
        energy: Double? = nil,
        beatGridOffset: TimeInterval? = nil,
        bpmConfidence: Double? = nil,
        keyConfidence: Double? = nil,
        energyConfidence: Double? = nil
    ) {
        self.bpm = bpm
        self.camelotKey = camelotKey
        self.energy = energy.map { min(max($0, 0), 1) }
        self.beatGridOffset = beatGridOffset
        self.bpmConfidence = bpmConfidence
        self.keyConfidence = keyConfidence
        self.energyConfidence = energyConfidence
    }
}

public struct Track: Identifiable, Codable, Equatable, Sendable {
    public let id: UUID
    /// Stable identifier for a user-authorized local file. The app layer owns
    /// security-scoped URL/bookmark handling; the core stores the URL value.
    public var fileURL: URL
    public var duration: TimeInterval?
    public var metadata: TrackMetadata
    public var analysis: TrackAnalysis

    public init(
        id: UUID = UUID(),
        fileURL: URL,
        duration: TimeInterval? = nil,
        metadata: TrackMetadata = .init(),
        analysis: TrackAnalysis = .init()
    ) {
        self.id = id
        self.fileURL = fileURL
        self.duration = duration
        self.metadata = metadata
        self.analysis = analysis
    }
}
