import Foundation

/// Multi logger class to log for multiple loggers at once
public final class MultiLogger : Logger {
    /// Loggers to invoke
    public var loggers: [Logger] = []

    /// Initializes multiple loggers
    public init(loggers: [Logger]) {
        self.loggers = loggers
    }

    /// Logs a message as `default` for all loggers
    public func `default`(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        invokeLoggers { (logger: Logger) in
            logger.default(message, category: category, file: file, function: function, line: line)
        }
    }

    /// Logs a message as `debug` for all loggers
    public func debug(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        invokeLoggers { (logger: Logger) in
            logger.debug(message, category: category, file: file, function: function, line: line)
        }
    }

    /// Logs a message as `info` for all loggers
    public func info(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        invokeLoggers { (logger: Logger) in
            logger.info(message, category: category, file: file, function: function, line: line)
        }
    }

    /// Logs a message as `error` for all loggers
    public func error(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        invokeLoggers { (logger: Logger) in
            logger.error(message, category: category, file: file, function: function, line: line)
        }
    }

    /// Logs a message as `fault` for all loggers
    public func fault(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        invokeLoggers { (logger: Logger) in
            logger.fault(message, category: category, file: file, function: function, line: line)
        }
    }

    private func invokeLoggers(function: @escaping (Logger) -> Void) {
        for logger: Logger in loggers {
            if logger is AsyncLogger {
                DispatchQueue.global(qos: .background).async {
                    function(logger)
                }
            } else {
                function(logger)
            }
        }
    }
}
