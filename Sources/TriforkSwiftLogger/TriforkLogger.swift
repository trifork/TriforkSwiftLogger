import Foundation
import os.log

/// Default `os_log` wrapper
public final class TriforkLogger : Logger {

    /// Sets a custom configuration of TriforkLogger
    public var config = TriforkLoggerConfig.default() {
        didSet {
            if oldValue.isEmojisEnabled && !config.isEmojisEnabled {
                self.default("An old grumpy man disabled emojis 💩")
            }
        }
    }

    public init(config: TriforkLoggerConfig? = nil) {
        self.config = config ?? TriforkLoggerConfig.default()
    }

    /// MARK: - Private functions
    private func log(_ message: String, at level: OSLogType, file: String, function: String, line: UInt, category: String) {
        guard !config.isSuspended else {
            return
        }

        if shouldPrint(level) {
            let logMessage = constructLogMessage(message, at: level, file: file, function: function, line: line, category: category)
            os_log("%@", log: OSLog.log(category: category), type: level, logMessage)
        }
    }

    /// MARK: - Internal functions
    internal func shouldPrint(_ level: OSLogType) -> Bool {
        config.minimumLogLevel <= level
    }

    internal func constructLogMessage(_ message: String, at level: OSLogType, file: String, function: String, line: UInt, category: String) -> String {
        let logMessage: String
        let emojiString = config.isEmojisEnabled ? level.emoji : "[\(level.title)]"
        if config.isDevelopmentInfoEnabled {
            let filePath = URL(fileURLWithPath: file)
            logMessage = "\(emojiString) \(filePath.lastPathComponent):\(line) - \(function) | \(message)"
        } else {
            logMessage = "\(emojiString) \(message)"
        }
        return logMessage
    }

    /// MARK: - Logger interface
    ///
    /// Logs a message as `default`
    public func `default`(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .default, file: file, function: function, line: line, category: category ?? config.defaultCategory)
    }

    /// Logs a message as `debug`
    public func debug(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .debug, file: file, function: function, line: line, category: category ?? config.defaultCategory)
    }

    /// Logs a message as `info`
    public func info(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .info, file: file, function: function, line: line, category: category ?? config.defaultCategory)
    }

    /// Logs a message as `error`
    public func error(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .error, file: file, function: function, line: line, category: category ?? config.defaultCategory)
    }

    /// Logs a message as `fault`
    public func fault(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .fault, file: file, function: function, line: line, category: category ?? config.defaultCategory)
    }
}

private extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "<missing bundleId>"

    static func log(category: String) -> OSLog {
        OSLog(subsystem: subsystem, category: category)
    }
}
