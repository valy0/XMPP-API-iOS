//
//  UIDevice+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import LocalAuthentication

extension UIDevice {
    
    // MARK: Public Methods
    
    static var touchIdIsAvailable: Bool {
        let context = LAContext()
        var error: NSError?
        
        if !context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            Logger.log("LA Auth Error: \(error?.localizedDescription ?? "N/A")")
            return false
        }
        
        return true
    }
    
    static var deviceId: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    static var isIphone4OrLess: Bool {
        return isIphone && screenMaxLength < 568.0
    }

    static var isIphone5: Bool {
        return isIphone && screenMaxLength == 568.0
    }
    
    static var isIphone6: Bool {
        return isIphone && screenMaxLength == 667.0
    }
    
    static var isIphonePlus: Bool {
        return isIphone && screenMaxLength == 736.0
    }
    
    
    // MARK: Private methods
    
    private static var isIpad: Bool {
        return UI_USER_INTERFACE_IDIOM() == .pad
    }
    
    private static var isIphone: Bool {
        return UI_USER_INTERFACE_IDIOM() == .phone
    }
    
    private static var isRetina: Bool {
        return UIScreen.main.scale >= 2.0
    }
    
    private static  var screenMaxLength: Float {
        return Float(max(UIScreen.width, UIScreen.height))
    }
    
    private static var screenMinLength: Float {
        return Float(min(UIScreen.width, UIScreen.height))
    }
}
