import Foundation

public struct CompatibilityFactors: Equatable, Sendable {
    public let harmony: Double?
    public let tempo: Double?
    public let energy: Double?
    public let total: Double?
    public let reasons: [String]

    public init(harmony: Double?, tempo: Double?, energy: Double?, total: Double?, reasons: [String]) {
        self.harmony = harmony
        self.tempo = tempo
        self.energy = energy
        self.total = total
        self.reasons = reasons
    }
}

/// Transparent first-pass ranking. It is intentionally conservative and does
/// not claim that a numeric score guarantees a good-sounding transition.
public struct CompatibilityEngine: Sendable {
    public init() {}

    /// Compares full library tracks, using analyzed values first and embedded
    /// ID3 BPM/key tags as fallback metadata when analysis is not available.
    public func compare(_ first: Track, _ second: Track) -> CompatibilityFactors {
        let firstAnalysis = TrackAnalysis(
            bpm: first.analysis.bpm ?? first.metadata.bpm,
            camelotKey: first.analysis.camelotKey ?? first.metadata.musicalKey,
            energy: first.analysis.energy,
            beatGridOffset: first.analysis.beatGridOffset,
            bpmConfidence: first.analysis.bpmConfidence,
            keyConfidence: first.analysis.keyConfidence,
            energyConfidence: first.analysis.energyConfidence
        )
        let secondAnalysis = TrackAnalysis(
            bpm: second.analysis.bpm ?? second.metadata.bpm,
            camelotKey: second.analysis.camelotKey ?? second.metadata.musicalKey,
            energy: second.analysis.energy,
            beatGridOffset: second.analysis.beatGridOffset,
            bpmConfidence: second.analysis.bpmConfidence,
            keyConfidence: second.analysis.keyConfidence,
            energyConfidence: second.analysis.energyConfidence
        )
        return compare(firstAnalysis, secondAnalysis)
    }

    public func compare(_ first: TrackAnalysis, _ second: TrackAnalysis) -> CompatibilityFactors {
        let harmony = harmonyScore(first.camelotKey, second.camelotKey)
        let tempo = tempoScore(first.bpm, second.bpm)
        let energy = energyScore(first.energy, second.energy)

        let weighted: [(Double?, Double)] = [
            (harmony, 0.40),
            (tempo, 0.35),
            (energy, 0.25)
        ]
        let available = weighted.compactMap { score, weight in
            score.map { ($0, weight) }
        }
        let weightTotal = available.reduce(0.0) { $0 + $1.1 }
        let total = weightTotal > 0
            ? available.reduce(0.0) { $0 + $1.0 * $1.1 } / weightTotal
            : nil

        var reasons: [String] = []
        if let harmony {
            reasons.append(harmony >= 0.95 ? "Tonalidad compatible" : harmony >= 0.65 ? "Relación armónica cercana" : "Relación armónica menos directa")
        }
        if let tempo {
            reasons.append(tempo >= 0.9 ? "BPM muy cercanos" : tempo >= 0.65 ? "BPM ajustables" : "Diferencia de BPM considerable")
        }
        if let energy {
            reasons.append(energy >= 0.85 ? "Energía similar" : energy >= 0.6 ? "Contraste de energía moderado" : "Contraste de energía alto")
        }
        if reasons.isEmpty {
            reasons.append("Faltan datos de análisis para comparar")
        }

        return CompatibilityFactors(
            harmony: harmony,
            tempo: tempo,
            energy: energy,
            total: total,
            reasons: reasons
        )
    }

    private func tempoScore(_ lhs: Double?, _ rhs: Double?) -> Double? {
        guard let lhs, let rhs, lhs > 0, rhs > 0 else { return nil }
        let relativeDifference = abs(lhs - rhs) / max(lhs, rhs)
        return min(max(1.0 - relativeDifference / 0.12, 0), 1)
    }

    private func energyScore(_ lhs: Double?, _ rhs: Double?) -> Double? {
        guard let lhs, let rhs else { return nil }
        return min(max(1.0 - abs(lhs - rhs), 0), 1)
    }

    private func harmonyScore(_ lhs: String?, _ rhs: String?) -> Double? {
        guard let lhs = parseCamelot(lhs), let rhs = parseCamelot(rhs) else { return nil }
        if lhs.number == rhs.number && lhs.letter == rhs.letter { return 1.0 }
        if lhs.number == rhs.number && lhs.letter != rhs.letter { return 0.95 } // relative major/minor
        if lhs.letter == rhs.letter {
            let distance = min(abs(lhs.number - rhs.number), 12 - abs(lhs.number - rhs.number))
            if distance == 1 { return 0.9 }
            if distance == 2 { return 0.65 }
        }
        return 0.25
    }

    private func parseCamelot(_ value: String?) -> (number: Int, letter: Character)? {
        guard let value else { return nil }
        let normalized = value.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard normalized.count >= 2,
              let letter = normalized.last,
              letter == "A" || letter == "B",
              let number = Int(normalized.dropLast()),
              (1...12).contains(number) else { return nil }
        return (number, letter)
    }
}
