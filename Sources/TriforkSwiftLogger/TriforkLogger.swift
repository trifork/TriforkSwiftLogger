import Foundation
import os.log

public final class TriforkLogger {

    /// Sets a custom configuration of TriforkLogger
    public static var config = TriforkLoggerConfig.default() {
        didSet {
            if oldValue.isEmojisEnabled && !config.isEmojisEnabled {
                TriforkLogger.default("An old grumpy man disabled emojis 💩")
            }
        }
    }

    /// MARK: - Private functions
    private static func log(_ message: String, at level: OSLogType, file: String, function: String, line: UInt, category: String) {
        guard !config.isSuspended else {
            return
        }

        if shouldPrint(level) {
            let logMessage = constructLogMessage(message, at: level, file: file, function: function, line: line, category: category)
            os_log("%@", log: OSLog.log(category: category), type: level, logMessage)
        }

        if config.listener?.isListeningForAllLevels == true || shouldPrint(level) {
            config.listener?.handleLogMessage(message, level: level, file: file, function: function, line: line, category: category)
        }
    }

    /// MARK: - Internal functions
    internal static func shouldPrint(_ level: OSLogType) -> Bool {
        config.minimumLogLevel <= level
    }

    internal static func constructLogMessage(_ message: String, at level: OSLogType, file: String, function: String, line: UInt, category: String) -> String {
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

    /// MARK: - Public functions
    /// Logs a message as `default`
    public static func `default`(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .default, file: file, function: function, line: line, category: category ?? config.defaultCategory)
    }

    /// Logs a message as `debug`
    public static func debug(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .debug, file: file, function: function, line: line, category: category ?? config.defaultCategory)
    }

    /// Logs a message as `info`
    public static func info(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .info, file: file, function: function, line: line, category: category ?? config.defaultCategory)
    }

    /// Logs a message as `error`
    public static func error(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .error, file: file, function: function, line: line, category: category ?? config.defaultCategory)
    }

    /// Logs a message as `fault`
    public static func fault(_ message: String, category: String? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .fault, file: file, function: function, line: line, category: category ?? config.defaultCategory)
    }
}

private extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "<missing bundleId>"

    static func log(category: String) -> OSLog {
        OSLog(subsystem: subsystem, category: category)
    }
}
