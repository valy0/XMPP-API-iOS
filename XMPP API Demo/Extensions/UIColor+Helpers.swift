//
//  UIColor+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: Public Methods
    
    
    static var navigationBarDefaultColor: UIColor {
        return self.colorWithRGB(247.0 / 255.0)
    }
    
    static var backgroundGray: UIColor {
        return self.withHex(Colors.backgroundGray)
    }
    
    static var navigationBarDefaultBackgroundColor: UIColor {
        return self.colorWithRGB(246.0 / 255.0)
    }
    
    static var activeGreenColor: UIColor {
        return UIColor.withHex(Colors.activeGreen)
    }
    
    static var deleteRedColor: UIColor {
        return UIColor.withHex(Colors.deleteRed)
    }
    
    static var separatorColor: UIColor {
        return UIColor.withHex(Colors.separatorGray)
    }
    
    static var defaultTextColor: UIColor {
        return UIColor.black
    }
    
    
    // MARK: Private Methods
    
    private class func colorWithRGB(_ rgb: CGFloat) -> UIColor {
        return self.colorWithRGB(rgb, alpha: 1.0)
    }
    
    private class func colorWithRGB(_ rgb: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: rgb, green: rgb, blue: rgb, alpha: alpha)
    }
}
