//
//  NSString+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension NSString {
    
    // MARK: Public Methods
    
    var isEmpty: Bool {
        return self.length == 0
    }
    
    var isNumeric: Bool {
        return self.length == self.numbersOnly.length
    }
    
    var trimmedString: NSString {
        return self.replacingOccurrences(of: " ", with: "") as NSString
    }
    
    var numbersOnly: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }
    
    var urlEncodedString: NSString {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)! as NSString
    }
}
