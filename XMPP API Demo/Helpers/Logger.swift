//
//  Logger.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

struct Logger {
    
    // MARK: Public Methods
    
    static func log<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        #if InDebug
            let value = object()
            let stringRepresentation: String
            
            if let value = value as? CustomDebugStringConvertible {
                stringRepresentation = value.debugDescription
            } else if let value = value as? CustomStringConvertible {
                stringRepresentation = value.description
            } else {
                debugPrint("Logging only works for values that conform to CustomDebugStringConvertible or CustomStringConvertible")
                return
            }
            
            let date    = NSDate()
            let queue   = Thread.isMainThread ? "UI" : "BG"
            let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file"
            
            print("[\(queue)] \(date) \(stringRepresentation) \(function) <\(fileURL)[\(line)]>")
        #endif
    }
}
