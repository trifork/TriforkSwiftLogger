import Foundation

/// Configuration model for `TriforkLogger`
public struct OSLoggerConfig {

    /// Public initializer
    public init(defaultCategory: String, minimumLogLevel: LogLevel, isDevelopmentInfoEnabled: Bool, isEmojisEnabled: Bool, isSuspended: Bool = false) {
        self.defaultCategory = defaultCategory
        self.minimumLogLevel = minimumLogLevel
        self.isDevelopmentInfoEnabled = isDevelopmentInfoEnabled
        self.isEmojisEnabled = isEmojisEnabled
        self.isSuspended = isSuspended
    }

    /// Sets the default category, that is used for `os_log` if none is specified for a log message
    public var defaultCategory: String

    /// Sets the minimum logLevel that you wish to see printed.
    public var minimumLogLevel: LogLevel

    /// Enables/disables development information in log messages, such as file name, line number and function name.
    public var isDevelopmentInfoEnabled: Bool

    /// Enables/disables emojis for log levels.
    public var isEmojisEnabled: Bool

    /// Suspends all actions by TriforkLogger - no logging will be performed
    public var isSuspended: Bool = false

    /// The default configuration for `TriforkLogger`
    /// category: `"default"`
    /// minmumLogLevel: `.default`
    /// printDevelopmentInfo: `false`
    /// listener: `nil`
    /// isEmojisEnabled: `true`
    public static func `default`() -> OSLoggerConfig {
        return OSLoggerConfig(
            defaultCategory: "default",
            minimumLogLevel: .debug,
            isDevelopmentInfoEnabled: false,
            isEmojisEnabled: true
        )
    }
}
