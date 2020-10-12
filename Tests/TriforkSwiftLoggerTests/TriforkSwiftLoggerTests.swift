import XCTest
import os.log
@testable import TriforkSwiftLogger

final class TriforkSwiftLoggerTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        TriforkLogger.config = TriforkLoggerConfig.default()
    }

    func testThatAllFunctionsCanBeCalled() {
        TriforkLogger.debug("Hello!")
        TriforkLogger.default("Hello!")
        TriforkLogger.info("Hello!")
        TriforkLogger.error("Hello!")
        TriforkLogger.fault("Hello!")
    }

    func testMinimumLogLevels() {
        TriforkLogger.config.minimumLogLevel = .default
        assertShouldPrint(trueLevels: [.default, .debug, .info, .error, .fault], falseLevels: [])

        TriforkLogger.config.minimumLogLevel = .debug
        assertShouldPrint(trueLevels: [.debug, .info, .error, .fault], falseLevels: [.default])

        TriforkLogger.config.minimumLogLevel = .info
        assertShouldPrint(trueLevels: [.info, .error, .fault], falseLevels: [.default, .debug])

        TriforkLogger.config.minimumLogLevel = .error
        assertShouldPrint(trueLevels: [.error, .fault], falseLevels: [.default, .debug, .info])

        TriforkLogger.config.minimumLogLevel = .fault
        assertShouldPrint(trueLevels: [.fault], falseLevels: [.default, .debug, .info, .error])
    }

    func testLogMessage() {
        TriforkLogger.config.isDevelopmentInfoEnabled = true
        let message = "Test test"
        let level = OSLogType.debug
        let fileName = "/Users/test/ATestFile.swift"
        let functionName = "aTestFunction"
        let line: UInt = 1337
        let category = "test-cat"
        let log = TriforkLogger.constructLogMessage(message, at: level, file: fileName, function: functionName, line: line, category: category)
        XCTAssertEqual(log, "🐛 ATestFile.swift:1337 - aTestFunction | Test test")

        TriforkLogger.config.isDevelopmentInfoEnabled = false
        let log2 = TriforkLogger.constructLogMessage(message, at: level, file: fileName, function: functionName, line: line, category: category)
        XCTAssertEqual(log2, "🐛 Test test")
    }

    func testEmojis() {
        TriforkLogger.config.isEmojisEnabled = false
        TriforkLogger.config.isDevelopmentInfoEnabled = false

        let log = TriforkLogger.constructLogMessage("Test test", at: .info, file: "fileName", function: "functionName", line: 1337, category: "category")
        XCTAssertEqual(log, "[INFO] Test test")

        TriforkLogger.config.isEmojisEnabled = true
        let log2 = TriforkLogger.constructLogMessage("Test test", at: .info, file: "fileName", function: "functionName", line: 1337, category: "category")
        XCTAssertEqual(log2, "ℹ️ Test test")
    }

    func testLogLevelData() {
        XCTAssertEqual(OSLogType.default.emoji, "📢")
        XCTAssertEqual(OSLogType.default.title, "DEFAULT")

        XCTAssertEqual(OSLogType.debug.emoji, "🐛")
        XCTAssertEqual(OSLogType.debug.title, "DEBUG")

        XCTAssertEqual(OSLogType.info.emoji, "ℹ️")
        XCTAssertEqual(OSLogType.info.title, "INFO")

        XCTAssertEqual(OSLogType.error.emoji, "🔥")
        XCTAssertEqual(OSLogType.error.title, "ERROR")

        XCTAssertEqual(OSLogType.fault.emoji, "💥")
        XCTAssertEqual(OSLogType.fault.title, "FAULT")
    }

    private func assertShouldPrint(trueLevels: [OSLogType], falseLevels: [OSLogType]) {
        for trueType in trueLevels {
            XCTAssertTrue(TriforkLogger.shouldPrint(trueType), "True type (\(trueType.title)) failed for \(TriforkLogger.config.minimumLogLevel.title)")
        }
        for falseType in falseLevels {
            XCTAssertFalse(TriforkLogger.shouldPrint(falseType), "False type (\(falseType.title)) failed for \(TriforkLogger.config.minimumLogLevel.title)")
        }
    }

    static var allTests = [
        ("testThatAllFunctionsCanBeCalled", testThatAllFunctionsCanBeCalled),
        ("testMinimumLogLevels", testMinimumLogLevels),
        ("testLogMessage", testLogMessage),
        ("testEmojis", testEmojis),
        ("testLogLevelData", testLogLevelData),
    ]
}
