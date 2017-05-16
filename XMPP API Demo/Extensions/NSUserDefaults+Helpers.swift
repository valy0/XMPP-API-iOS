//
//  NSUserDefaults+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import SecureNSUserDefaults

extension UserDefaults {
    
    // MARK: Setters
    
    class func setDeviceData() {
        self.standard.setSecret(Constants.secret)
    }
}
