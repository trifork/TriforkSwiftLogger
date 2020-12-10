import Foundation

/// Multi logger class to log for multiple loggers at once
public final class MultiLogger : LoggerProtocol {
    /// Loggers to invoke
    public var loggers: [LoggerProtocol] = []

    /// Initializes multiple loggers
    public init(loggers: [LoggerProtocol]) {
        self.loggers = loggers
    }

    public func log(_ message: String, at level: LogLevel, file: String, function: String, line: UInt, category: String?) {
        invokeLoggers { (logger: LoggerProtocol) in
            logger.log(message, at: level, file: file, function: function, line: line, category: category)
        }
    }

    private func invokeLoggers(function: @escaping (LoggerProtocol) -> Void) {
        for logger: LoggerProtocol in loggers {
            function(logger)
        }
    }
}
