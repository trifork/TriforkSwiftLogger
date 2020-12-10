import XCTest
import os.log
@testable import TriforkSwiftLogger

final class OSLoggerTests: XCTestCase {
    
    func testThatAllFunctionsCanBeCalled() {
        let osLogger = OSLogger()
        osLogger.debug("Hello!")
        osLogger.info("Hello!")
        osLogger.warning("Hello!")
        osLogger.error("Hello!")
        osLogger.critical("Hello!")
    }

    func testMinimumLogLevels() {
        let osLogger = OSLogger()
        osLogger.config.minimumLogLevel = .debug
        osLogger.assertShouldPrint(trueLevels: [.debug, .info, .warning, .error, .critical], falseLevels: [])

        osLogger.config.minimumLogLevel = .info
        osLogger.assertShouldPrint(trueLevels: [.info, .error, .critical], falseLevels: [.debug])

        osLogger.config.minimumLogLevel = .warning
        osLogger.assertShouldPrint(trueLevels: [.warning, .error, .critical], falseLevels: [.debug, .info])

        osLogger.config.minimumLogLevel = .error
        osLogger.assertShouldPrint(trueLevels: [.error, .critical], falseLevels: [.debug, .info, .warning])

        osLogger.config.minimumLogLevel = .critical
        osLogger.assertShouldPrint(trueLevels: [.critical], falseLevels: [.debug, .info, .warning, .error])
    }

    func testLogMessage() {
        let osLogger = OSLogger()
        osLogger.config.isDevelopmentInfoEnabled = true
        let message = "Test test"
        let level = LogLevel.debug
        let fileName = "/Users/test/ATestFile.swift"
        let functionName = "aTestFunction"
        let line: UInt = 1337
        let log = osLogger.constructLogMessage(message, at: level, file: fileName, function: functionName, line: line)
        XCTAssertEqual(log, "🐛 ATestFile.swift:1337 - aTestFunction | Test test")

        osLogger.config.isDevelopmentInfoEnabled = false
        let log2 = osLogger.constructLogMessage(message, at: level, file: fileName, function: functionName, line: line)
        XCTAssertEqual(log2, "🐛 Test test")
    }

    func testEmojis() {
        let osLogger = OSLogger()
        osLogger.config.isEmojisEnabled = false
        osLogger.config.isDevelopmentInfoEnabled = false

        let log = osLogger.constructLogMessage("Test test", at: .info, file: "fileName", function: "functionName", line: 1337)
        XCTAssertEqual(log, "[INFO] Test test")

        osLogger.config.isEmojisEnabled = true
        let log2 = osLogger.constructLogMessage("Test test", at: .info, file: "fileName", function: "functionName", line: 1337)
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


private extension OSLogger {
    func assertShouldPrint(trueLevels: [LogLevel], falseLevels: [LogLevel]) {
        for trueType in trueLevels {
            XCTAssertTrue(shouldPrint(trueType), "True type (\(trueType.title)) failed for \(config.minimumLogLevel.title)")
        }
        for falseType in falseLevels {
            XCTAssertFalse(shouldPrint(falseType), "False type (\(falseType.title)) failed for \(config.minimumLogLevel.title)")
        }
    }
}
