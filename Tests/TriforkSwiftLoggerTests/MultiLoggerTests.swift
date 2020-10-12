import XCTest
import os.log
@testable import TriforkSwiftLogger

final class MultiLoggerTests: XCTestCase {

    func testMultiLogger() {
        let expect1 = XCTestExpectation()
        let expect2 = XCTestExpectation()

        let singleLogger1 = TestAsyncLogger(expectation: expect2)
        let singleLogger2 = TestAsyncLogger(expectation: expect1)
        let singleLogger3 = TestLogger()
        let singleLogger4 = TestLogger()

        let multiLogger = MultiLogger(loggers: [singleLogger1, singleLogger2, singleLogger3, singleLogger4])

        multiLogger.default("Invoke all the loggers!")
        multiLogger.debug("Invoke all the loggers!")
        multiLogger.info("Invoke all the loggers!")
        multiLogger.error("Invoke all the loggers!")
        multiLogger.fault("Invoke all the loggers!")

        // 1 and 2 should be false here, because default log function is sleeping
        XCTAssertFalse(singleLogger1.isFulfilled())
        XCTAssertFalse(singleLogger2.isFulfilled())

        // 3 and 4 should be true, because 1 and 2 are running as async
        XCTAssertTrue(singleLogger3.isFulfilled())
        XCTAssertTrue(singleLogger4.isFulfilled())

        wait(for: [expect1, expect2], timeout: 5.0)

        XCTAssertTrue(singleLogger1.isFulfilled())
        XCTAssertTrue(singleLogger2.isFulfilled())
        XCTAssertTrue(singleLogger3.isFulfilled())
        XCTAssertTrue(singleLogger4.isFulfilled())
    }
}

class TestLogger : Logger {
    var invoked: [String: Bool] = [
        OSLogType.default.title: false,
        OSLogType.debug.title: false,
        OSLogType.info.title: false,
        OSLogType.error.title: false,
        OSLogType.fault.title: false
    ]

    // MARK: - Logger
    func `default`(_ message: String, category: String?, file: String, function: String, line: UInt) {
        invoked[OSLogType.default.title] = true
    }

    func debug(_ message: String, category: String?, file: String, function: String, line: UInt) {
        invoked[OSLogType.debug.title] = true
    }

    func info(_ message: String, category: String?, file: String, function: String, line: UInt) {
        invoked[OSLogType.info.title] = true
    }

    func error(_ message: String, category: String?, file: String, function: String, line: UInt) {
        invoked[OSLogType.error.title] = true
    }

    func fault(_ message: String, category: String?, file: String, function: String, line: UInt) {
        invoked[OSLogType.fault.title] = true
    }

    func isFulfilled() -> Bool {
        invoked.allSatisfy({ $0.value })
    }
}

class TestAsyncLogger : TestLogger, AsyncLogger {

    let expectation: XCTestExpectation

    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }

    // MARK: - Logger
    override func `default`(_ message: String, category: String?, file: String, function: String, line: UInt) {
        sleep(1) //Sleep to prove that it is started as async
        super.default(message, category: category, file: file, function: function, line: line)
        fulfillExpectationIfDone()
    }

    override func debug(_ message: String, category: String?, file: String, function: String, line: UInt) {
        super.debug(message, category: category, file: file, function: function, line: line)
        fulfillExpectationIfDone()
    }

    override func info(_ message: String, category: String?, file: String, function: String, line: UInt) {
        super.info(message, category: category, file: file, function: function, line: line)
        fulfillExpectationIfDone()
    }

    override func error(_ message: String, category: String?, file: String, function: String, line: UInt) {
        super.error(message, category: category, file: file, function: function, line: line)
        fulfillExpectationIfDone()
    }

    override func fault(_ message: String, category: String?, file: String, function: String, line: UInt) {
        super.fault(message, category: category, file: file, function: function, line: line)
        fulfillExpectationIfDone()
    }

    private func fulfillExpectationIfDone() {
        if isFulfilled() {
            expectation.fulfill()
        }
    }
}
