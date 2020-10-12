import XCTest
import os.log
@testable import TriforkSwiftLogger

final class TriforkSwiftLoggerTests: XCTestCase {
    
    func testThatAllFunctionsCanBeCalled() {
        let triLogger = TriforkLogger()
        triLogger.debug("Hello!")
        triLogger.default("Hello!")
        triLogger.info("Hello!")
        triLogger.error("Hello!")
        triLogger.fault("Hello!")
    }

    func testMinimumLogLevels() {
        let triLogger = TriforkLogger()
        triLogger.config.minimumLogLevel = .default
        triLogger.assertShouldPrint(trueLevels: [.default, .debug, .info, .error, .fault], falseLevels: [])

        triLogger.config.minimumLogLevel = .debug
        triLogger.assertShouldPrint(trueLevels: [.debug, .info, .error, .fault], falseLevels: [.default])

        triLogger.config.minimumLogLevel = .info
        triLogger.assertShouldPrint(trueLevels: [.info, .error, .fault], falseLevels: [.default, .debug])

        triLogger.config.minimumLogLevel = .error
        triLogger.assertShouldPrint(trueLevels: [.error, .fault], falseLevels: [.default, .debug, .info])

        triLogger.config.minimumLogLevel = .fault
        triLogger.assertShouldPrint(trueLevels: [.fault], falseLevels: [.default, .debug, .info, .error])
    }

    func testLogMessage() {
        let triLogger = TriforkLogger()
        triLogger.config.isDevelopmentInfoEnabled = true
        let message = "Test test"
        let level = OSLogType.debug
        let fileName = "/Users/test/ATestFile.swift"
        let functionName = "aTestFunction"
        let line: UInt = 1337
        let log = triLogger.constructLogMessage(message, at: level, file: fileName, function: functionName, line: line)
        XCTAssertEqual(log, "🐛 ATestFile.swift:1337 - aTestFunction | Test test")

        triLogger.config.isDevelopmentInfoEnabled = false
        let log2 = triLogger.constructLogMessage(message, at: level, file: fileName, function: functionName, line: line)
        XCTAssertEqual(log2, "🐛 Test test")
    }

    func testEmojis() {
        let triLogger = TriforkLogger()
        triLogger.config.isEmojisEnabled = false
        triLogger.config.isDevelopmentInfoEnabled = false

        let log = triLogger.constructLogMessage("Test test", at: .info, file: "fileName", function: "functionName", line: 1337)
        XCTAssertEqual(log, "[INFO] Test test")

        triLogger.config.isEmojisEnabled = true
        let log2 = triLogger.constructLogMessage("Test test", at: .info, file: "fileName", function: "functionName", line: 1337)
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

    static var allTests = [
        ("testThatAllFunctionsCanBeCalled", testThatAllFunctionsCanBeCalled),
        ("testMinimumLogLevels", testMinimumLogLevels),
        ("testLogMessage", testLogMessage),
        ("testEmojis", testEmojis),
        ("testLogLevelData", testLogLevelData),
    ]
}


private extension TriforkLogger {
    func assertShouldPrint(trueLevels: [OSLogType], falseLevels: [OSLogType]) {
        for trueType in trueLevels {
            XCTAssertTrue(shouldPrint(trueType), "True type (\(trueType.title)) failed for \(config.minimumLogLevel.title)")
        }
        for falseType in falseLevels {
            XCTAssertFalse(shouldPrint(falseType), "False type (\(falseType.title)) failed for \(config.minimumLogLevel.title)")
        }
    }
}
