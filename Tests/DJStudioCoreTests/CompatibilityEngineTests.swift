import XCTest
@testable import DJStudioCore

final class CompatibilityEngineTests: XCTestCase {
    private let engine = CompatibilityEngine()

    func testSameCamelotKeyRanksAsFullyCompatibleHarmonically() {
        let result = engine.compare(
            TrackAnalysis(camelotKey: "8A"),
            TrackAnalysis(camelotKey: "8A")
        )
        XCTAssertEqual(result.harmony, 1.0)
    }

    func testAdjacentCamelotKeyIsRecognized() {
        let result = engine.compare(
            TrackAnalysis(camelotKey: "8A"),
            TrackAnalysis(camelotKey: "9A")
        )
        XCTAssertEqual(result.harmony, 0.9)
    }

    func testRelativeMajorMinorIsRecognized() {
        let result = engine.compare(
            TrackAnalysis(camelotKey: "8A"),
            TrackAnalysis(camelotKey: "8B")
        )
        XCTAssertEqual(result.harmony, 0.95)
    }

    func testMissingDataDoesNotInventCompatibilityScore() {
        let result = engine.compare(.init(), .init())
        XCTAssertNil(result.total)
        XCTAssertEqual(result.reasons, ["Faltan datos de análisis para comparar"])
    }

    func testTempoAndEnergyAreIncludedWhenAvailable() {
        let result = engine.compare(
            TrackAnalysis(bpm: 128, energy: 0.7),
            TrackAnalysis(bpm: 129, energy: 0.8)
        )
        XCTAssertNotNil(result.tempo)
        XCTAssertNotNil(result.energy)
        XCTAssertNotNil(result.total)
    }
}
