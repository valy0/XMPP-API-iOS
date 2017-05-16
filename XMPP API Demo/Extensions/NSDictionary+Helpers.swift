//
//  NSDictionary+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension Dictionary {
    mutating func appendDictionary(_ other:Dictionary) {
        for (key, value) in other {
            let _ = autoreleasepool(invoking: {
                self.updateValue(value, forKey:key)
            })
        }
    }
}

extension NSDictionary {
    
    // MARK: Public Methods
    
    class func requestForCommand(_ command: Int, extraData: [String : Any]?) -> NSDictionary {
        var data: [String : Any] = [
            Parameters.command  : command,
            Parameters.OS       : Constants.deviceOS,
            Parameters.version  : Constants.appVersion,
            Parameters.language : Constants.deviceLang!
        ]
        
        if let session = SessionManager.shared.user?.session {
            data[Parameters.session] = session
        }
        
        if let commandSpecificData = extraData {
            data.appendDictionary(commandSpecificData)
        }
        
        return data as NSDictionary
    }
    
    func appendDictionary(_ dictionary: NSDictionary) {
        for (key, value) in dictionary {
            autoreleasepool(invoking: {
                self.setValue(value, forKey: key as! String)
            })
        }
    }
    
    func toSocketData() -> Data {
        var jsonData: Data? = nil
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {}
        
        if (jsonData == nil) { return Data() }
        
        let fullData = NSMutableData()
        fullData.append(jsonData!.bytesOfLength())
        fullData.append(jsonData!)
        
        return fullData as Data
    }
}
