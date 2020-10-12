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

    public init(config: TriforkLoggerConfig = .default()) {
        self.config = config
    }

    public func log(_ message: String, at level: OSLogType, file: String, function: String, line: UInt, category: String?) {
        guard !config.isSuspended else {
            return
        }

        if shouldPrint(level) {
            let logMessage = constructLogMessage(message, at: level, file: file, function: function, line: line)
            os_log("%@", log: OSLog.log(category: category ?? config.defaultCategory), type: level, logMessage)
        }
    }

    /// MARK: - Internal functions
    internal func shouldPrint(_ level: OSLogType) -> Bool {
        config.minimumLogLevel <= level
    }

    internal func constructLogMessage(_ message: String, at level: OSLogType, file: String, function: String, line: UInt) -> String {
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
}

private extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "<missing bundleId>"

    static func log(category: String) -> OSLog {
        OSLog(subsystem: subsystem, category: category)
    }
}
