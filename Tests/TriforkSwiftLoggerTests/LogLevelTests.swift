import XCTest
import os.log
@testable import TriforkSwiftLogger

final class LogLevelTests: XCTestCase {
    func testLogLevelData() {
        XCTAssertEqual(LogLevel.debug.emoji, "🐛")
        XCTAssertEqual(LogLevel.debug.title, "DEBUG")

        XCTAssertEqual(LogLevel.info.emoji, "ℹ️")
        XCTAssertEqual(LogLevel.info.title, "INFO")

        XCTAssertEqual(LogLevel.warning.emoji, "⚠️")
        XCTAssertEqual(LogLevel.warning.title, "WARNING")

        XCTAssertEqual(LogLevel.error.emoji, "🔴")
        XCTAssertEqual(LogLevel.error.title, "ERROR")

        XCTAssertEqual(LogLevel.critical.emoji, "🔥")
        XCTAssertEqual(LogLevel.critical.title, "CRITICAL")
    }

    static var allTests = [
        ("testLogLevelData", testLogLevelData),
    ]
}
