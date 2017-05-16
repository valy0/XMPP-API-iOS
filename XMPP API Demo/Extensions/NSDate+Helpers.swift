//
//  NSDate+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension Date {
    
    // MARK: Public Methods
    
    static func currentTimestamp() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
    
    static func currentTime() -> String {
        return DateFormatter.fullDateTimeFormatter().string(from: Date())
    }
    
    static func currentYear() -> String {
        return DateFormatter.yearDateFormatter().string(from: Date())
    }
    
    static func UTCDateString() -> String {
        return DateFormatter.dateTimeFormatter().string(from: Date())
    }
    
    static func toLocalTime(_ dateString: String) -> String {
        return DateFormatter.dateTimeFormatter().string(from: self.dateFromString(dateString))
    }
    
    static func UTCDate() -> Date {
        return Date.dateFromString(DateFormatter.UTCDateTimeFormatter().string(from: Date()))
    }
    
    static func dateFromString(_ string: String) -> Date {
        return DateFormatter.dateFormatter().date(from: string)!
    }
    
    static func substringDate(_ date: String) -> String {
        return date.components(separatedBy: " ").first!
    }
}
