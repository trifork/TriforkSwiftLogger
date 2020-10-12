import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TriforkSwiftLoggerTests.allTests),
        testCase(MultiLoggerTests.allTests),
    ]
}
#endif
