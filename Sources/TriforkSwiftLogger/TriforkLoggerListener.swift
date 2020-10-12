import Foundation
import os.log

public protocol TriforkLoggerListener {
    var isListeningForAllLevels: Bool { get }
    func handleLogMessage(_ message: String, level: OSLogType, file: String, function: String, line: UInt, category: String)
}
