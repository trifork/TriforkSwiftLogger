//
//  PrintLogger.swift
//  Watchable
//
//  Created by Kim de Vos on 25/07/2019.
//  Copyright © 2019 Trifork A/S. All rights reserved.
//

import Foundation
import os.log

public final class TriforkLogger {
    public static var defaultCategory: String = "default"
    public static var minimumLogLevel: OSLogType = .debug

    private static func log(_ message: String, at level: OSLogType, file: String, function: String, line: UInt, category: String) {
        guard minimumLogLevel >= level else { return }
        os_log("%@ (%@:%d - %@) %@ ", log: OSLog.log(category: category), type: .info, level.emoji, file, line, function, message)
    }

    public static func `default`(_ message: String, category: String = defaultCategory, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .default, file: file, function: function, line: line, category: category)
    }

    public static func debug(_ message: String, category: String = defaultCategory, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .debug, file: file, function: function, line: line, category: category)
    }

    public static func info(_ message: String, category: String = defaultCategory, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .info, file: file, function: function, line: line, category: category)
    }

    public static func error(_ message: String, category: String = defaultCategory, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .error, file: file, function: function, line: line, category: category)
    }

    public static func fault(_ message: String, category: String = defaultCategory, file: String = #file, function: String = #function, line: UInt = #line) {
        log(message, at: .fault, file: file, function: function, line: line, category: category)
    }
}

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "<missing bundleId>"

    static func log(category: String) -> OSLog {
        OSLog(subsystem: subsystem, category: category)
    }
}

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
