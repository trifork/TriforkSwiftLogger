//
//  PrintLogger.swift
//  Watchable
//
//  Created by Kim de Vos on 25/07/2019.
//  Copyright © 2019 Trifork A/S. All rights reserved.
//

import Foundation

public final class PrintLogger: Logger {
    static var minimumLogLevel: LogLevel = .debug

    private init() { }

    public static func log(_ string: String, at level: LogLevel, file: String, function: String, line: UInt) {
        guard minimumLogLevel >= level else { return }
        Swift.print("\(level.emoji) (\(file):\(line) - \(function)) \(string) ")
    }
}
