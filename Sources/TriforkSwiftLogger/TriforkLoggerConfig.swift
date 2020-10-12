import Foundation
import os.log

/// Configuration model for `TriforkLogger`
public struct TriforkLoggerConfig {
    /// Sets the default category, that is used for `os_log` if none is specified for a log message
    var defaultCategory: String

    /// Sets the minimum logLevel that you wish to see printed.
    var minimumLogLevel: OSLogType

    /// Enables/disables development information in log messages, such as file name, line number and function name.
    var isDevelopmentInfoEnabled: Bool

    /// Sets a listener, which will be invoked for all log messages. The listener will respect `minimumLogLevel` unless it is configured differently.
    var listener: TriforkLoggerListener?

    /// Enables/disables emojis for log levels.
    var isEmojisEnabled: Bool

    /// Suspends all actions by TriforkLogger - no logging will be performed
    var isSuspended: Bool = false

    /// The default configuration for `TriforkLogger`
    /// category: `"default"`
    /// minmumLogLevel: `.default`
    /// printDevelopmentInfo: `false`
    /// listener: `nil`
    /// isEmojisEnabled: `true`
    static func `default`() -> TriforkLoggerConfig {
        return TriforkLoggerConfig(
            defaultCategory: "default",
            minimumLogLevel: .default,
            isDevelopmentInfoEnabled: false,
            listener: nil,
            isEmojisEnabled: true
        )
    }
}
