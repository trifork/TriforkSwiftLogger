import Foundation
import os.log

/// Multi logger class to log for multiple loggers at once
public final class MultiLogger : Logger {
    /// Loggers to invoke
    public var loggers: [Logger] = []

    /// Initializes multiple loggers
    public init(loggers: [Logger]) {
        self.loggers = loggers
    }

    public func log(_ message: String, at level: OSLogType, file: String, function: String, line: UInt, category: String?) {
        invokeLoggers { (logger: Logger) in
            logger.log(message, at: level, file: file, function: function, line: line, category: category)
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
