//
//  String+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
    // MARK: Public Methods
    
    var isEmpty: Bool {
        return self.characters.count == 0
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var phoneNumber: String {
        return self.replacingOccurrences(of: "[^0-9+]",
                                         with: "",
                                         options: .regularExpression,
                                         range: self.range(of: self))
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    var intValue: Int {
        return (self as NSString).integerValue
    }
    
    var length: Int {
        return self.characters.count
    }
    
    func size(_ font: UIFont) -> CGSize {
        return self.size(font: font, sidePadding: 0.0)
    }
    
    func size(font: UIFont, sidePadding: CGFloat) -> CGSize {
        var attributes: [String : Any] = [NSFontAttributeName : font]
        
        if let paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle {
            paragraphStyle.alignment     = .center
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            attributes[NSParagraphStyleAttributeName] = paragraphStyle
        }
        
        return (self as NSString).boundingRect(with: CGSize(width: UIScreen.width - (2 * sidePadding),
                                                            height: CGFloat.greatestFiniteMagnitude),
                                               options: [.usesFontLeading, .usesLineFragmentOrigin],
                                               attributes: attributes,
                                               context: nil).size
    }
    
    var urlEncodedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
    }
    
    func substring(to: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: to)
        return self.substring(to: index)
    }
    
    func substring(from: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: from)
        return self.substring(from: index)
    }
    
    func substring(from: Int, to: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: from)
        let end   = self.index(self.endIndex,   offsetBy: to)
        let range = start..<end
        
        return self.substring(with: range)
    }
    
    var isLatinCharactersOnly: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9 ]+$")
        return predicate.evaluate(with: self)
    }
    
    var removedNewLineCharacters: String {
        return self.replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: "")
    }
}
