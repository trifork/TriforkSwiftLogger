import Foundation

/// Logger protocol
public protocol LoggerProtocol {
    func log(_ message: String, at level: LogLevel, file: String, function: String, line: UInt, category: String?)
}

extension LoggerProtocol {
    /// Logs a message as `debug`
    public func debug(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .debug, file: file, function: function, line: line, category: category)
    }

    /// Logs a message as `info`
    public func info(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .info, file: file, function: function, line: line, category: category)
    }

    /// Logs a message as `warning`
    public func warning(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .warning, file: file, function: function, line: line, category: category)
    }

    /// Logs a message as `error`
    public func error(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .error, file: file, function: function, line: line, category: category)
    }

    /// Logs a message as `critical`
    public func critical(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .critical, file: file, function: function, line: line, category: category)
    }
}
