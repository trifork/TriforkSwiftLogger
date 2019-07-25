//
//  LogLevel.swift
//  Watchable
//
//  Created by Kim de Vos on 25/07/2019.
//  Copyright © 2019 Trifork A/S. All rights reserved.
//

import Foundation

public enum LogLevel: Int, Comparable {
    case verbose
    case info
    case warning
    case debug
    case error
    case fatal

    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension LogLevel {
    var emoji: String {
        switch self {
        case .verbose: return "📢"
        case .info: return "ℹ️"
        case .warning: return "⚠️"
        case .debug: return "🐛"
        case .error: return "🔥"
        case .fatal: return "💥"
        }
    }
}
