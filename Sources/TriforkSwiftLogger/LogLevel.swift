import Foundation

public enum LogLevel: Comparable {
    /// Appropriate for messages that contain information normally of use only when
    /// debugging a program.
    case debug

    /// Appropriate for informational messages.
    case info

    /// Appropriate for messages that are not error conditions
    case warning

    /// Appropriate for error conditions.
    case error

    /// Appropriate for critical error conditions that usually require immediate
    /// attention.
    case critical

    var emoji: String {
        switch self {
        case .debug: return "🐛"
        case .info: return "ℹ️"
        case .warning: return "⚠️"
        case .error: return "🔴"
        case .critical: return "🔥"
        }
    }

    var title: String {
        switch self {
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        case .critical: return "CRITICAL"
        }
    }

    private var sortValue: Int {
        switch self {
        case .debug: return 0
        case .info: return 3
        case .warning: return 6
        case .error: return 8
        case .critical: return 10
        }
    }

    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.sortValue < rhs.sortValue
    }
}
