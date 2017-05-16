//
//  NSDateFormatter+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import Foundation

extension DateFormatter {
    
    // MARK: Public Methods
        
    class func timeFormatter() -> DateFormatter {
        return self.dateFormatterWithFormat(DateFormats.timeFormat)
    }
    
    class func dateFormatter() -> DateFormatter {
        return self.dateFormatterWithFormat(DateFormats.dateFormatter)
    }
    
    class func fullDateTimeFormatter() -> DateFormatter {
        return self.dateFormatter(DateFormats.fullDateTimeFormat, timeZone: TimeZones.utcTimeZone as TimeZone)
    }
    
    class func dateTimeFormatter() -> DateFormatter {
        return self.dateFormatterWithFormat(DateFormats.dateTimeFormatter)
    }
    
    class func serverDateFormatter() -> DateFormatter {
        return self.dateFormatterWithFormat(DateFormats.serverDateFormatter, setTimeZone: true)
    }
    
    class func yearDateFormatter() -> DateFormatter {
        return self.dateFormatterWithFormat(DateFormats.yearDateFormat)
    }
    
    class func UTCDateTimeFormatter() -> DateFormatter {
        return self.dateFormatter(DateFormats.dateTimeFormatter, timeZone: TimeZones.utcTimeZone as TimeZone)
    }
    
    
    // MARK: Private Methods
    
    private class func dateFormatterWithFormat(_ dateFormat: String) -> DateFormatter {
        return self.dateFormatterWithFormat(dateFormat, setTimeZone: false)
    }
    
    private class func dateFormatterWithFormat(_ dateFormat: String, setTimeZone: Bool) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = self.defaultLocale()
        dateFormatter.dateFormat = dateFormat
        
        if setTimeZone {
            dateFormatter.timeZone = TimeZone.current
        }
        
        return dateFormatter
    }
    
    private class func dateFormatter(_ dateFormat: String, timeZone: TimeZone) -> DateFormatter {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone   = timeZone
        return dateFormatter
    }
    
    
    // MARK: Helpers
    
    class func defaultLocale() -> Locale {
        return Locale(identifier: Constants.locale)
    }
    
    class func localizedDateFormatter() -> DateFormatter {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = DateFormats.localizedDateFormat
        dateFormatter.locale     = Locale.current
        dateFormatter.timeZone   = TimeZones.deviceTimeZone
        dateFormatter.dateStyle  = .medium
        
        return dateFormatter;
    }
}
