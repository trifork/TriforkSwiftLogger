import Foundation
import os.log

/// Logger protocol
public protocol Logger {
    func log(_ message: String, at level: OSLogType, file: String, function: String, line: UInt, category: String?)
}

/// Loggers who implement this protocol will be started on the background queue, when invoked from the MultiLogger
public protocol AsyncLogger : Logger {}


extension Logger {
    /// Logs a message as `default`
    public func `default`(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .default, file: file, function: function, line: line, category: category)
    }

    /// Logs a message as `debug`
    public func debug(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .debug, file: file, function: function, line: line, category: category)
    }

    /// Logs a message as `info`
    public func info(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .info, file: file, function: function, line: line, category: category)
    }

    /// Logs a message as `error`
    public func error(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .error, file: file, function: function, line: line, category: category)
    }

    /// Logs a message as `fault`
    public func fault(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .fault, file: file, function: function, line: line, category: category)
    }
}
