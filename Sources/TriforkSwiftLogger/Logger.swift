//
//  Logger.swift
//  Watchable
//
//  Created by Kim de Vos on 25/07/2019.
//  Copyright © 2019 Trifork A/S. All rights reserved.
//

import Foundation

public protocol Logger {
    static func log(_ string: String, at level: LogLevel, file: String, function: String, line: UInt)
}

extension Logger {

    public static func verbose(_ string: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(string, at: .verbose, file: file, function: function, line: line)
    }

    public static func debug(_ string: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(string, at: .debug, file: file, function: function, line: line)
    }

    public static func info(_ string: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(string, at: .info, file: file, function: function, line: line)
    }

    public static func warning(_ string: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(string, at: .warning, file: file, function: function, line: line)
    }

    public static func error(_ string: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(string, at: .error, file: file, function: function, line: line)
    }

    public static func fatal(_ string: String, file: String = #file, function: String = #function, line: UInt = #line) {
        self.log(string, at: .fatal, file: file, function: function, line: line)
    }
}
