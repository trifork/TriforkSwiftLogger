import XCTest
import os.log
@testable import TriforkSwiftLogger

final class MultiLoggerTests: XCTestCase {

    func testMultiLogger() {
        let singleLogger1 = TestLogger()
        let singleLogger2 = TestLogger()

        let multiLogger = MultiLogger(loggers: [singleLogger1, singleLogger2])

        multiLogger.debug("Invoke all the loggers!")
        multiLogger.info("Invoke all the loggers!")
        multiLogger.warning("Invoke all the loggers!")
        multiLogger.error("Invoke all the loggers!")
        multiLogger.critical("Invoke all the loggers!")

        XCTAssertTrue(singleLogger1.isFulfilled())
        XCTAssertTrue(singleLogger2.isFulfilled())
    }

    static var allTests = [
        ("testMultiLogger", testMultiLogger)
    ]
}

class TestLogger : LoggerProtocol {
    var invoked: [String: Bool] = [
        LogLevel.debug.title: false,
        LogLevel.info.title: false,
        LogLevel.warning.title: false,
        LogLevel.error.title: false,
        LogLevel.critical.title: false
    ]

    // MARK: - Logger
    func log(_ message: String, at level: LogLevel, file: String, function: String, line: UInt, category: String?) {
        invoked[level.title] = true
    }

    func isFulfilled() -> Bool {
        invoked.allSatisfy({ $0.value })
    }
}
