import XCTest
@testable import TriforkSwiftLogger

final class TriforkSwiftLoggerTests: XCTestCase {
    func testExample() {
        TriforkLogger.minimumLogLevel = .default
        TriforkLogger.debug("Hello!", category: "Custom cat")
        TriforkLogger.debug("Hello!")
        TriforkLogger.default("Hello!")
        TriforkLogger.info("Hello!")
        TriforkLogger.error("Hello!")
        TriforkLogger.fault("Hello!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
