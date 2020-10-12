import Foundation
import os.log

extension OSLogType: Comparable {
    var emoji: String {
        switch self {
        case .default: return "📢"
        case .info: return "ℹ️"
        case .debug: return "🐛"
        case .error: return "🔥"
        case .fault: return "💥"
        default: return "❓"
        }
    }

    var title: String {
        switch self {
        case .default: return "DEFAULT"
        case .info: return "INFO"
        case .debug: return "DEBUG"
        case .error: return "ERROR"
        case .fault: return "FAULT"
        default: return "UNKNOWN"
        }
    }

    private var sortValue: Int {
        switch self {
        case .default: return 0
        case .debug: return 2
        case .info: return 5
        case .error: return 7
        case .fault: return 10
        default: return -1
        }
    }

    public static func < (lhs: OSLogType, rhs: OSLogType) -> Bool {
        return lhs.sortValue < rhs.sortValue
    }
}
