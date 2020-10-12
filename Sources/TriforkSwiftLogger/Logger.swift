import Foundation

/// Logger protocol
public protocol Logger {
    func `default`(_ message: String, category: String?, file: String, function: String, line: UInt)
    func debug(_ message: String, category: String?, file: String, function: String, line: UInt)
    func info(_ message: String, category: String?, file: String, function: String, line: UInt)
    func error(_ message: String, category: String?, file: String, function: String, line: UInt)
    func fault(_ message: String, category: String?, file: String, function: String, line: UInt)
}

/// Loggers who implement this protocol will be started on the background queue, when invoked from the MultiLogger
public protocol AsyncLogger : Logger {}
