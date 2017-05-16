//
//  NSData+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import Foundation

extension Data {
    
    // MARK: Public Methods
    
    func bytesToInt() -> UInt {
        var value: UInt32 = 0
        (self as NSData).getBytes(&value, length: 4)
        value = UInt32(bigEndian: value)
        
        return UInt(value)
    }
    
    func bytesOfLength() -> Data {
        var length = CFSwapInt16HostToBig(UInt16(self.count))
        let data   = Data(bytes:&length, count: self.count)
        
        return data.subdata(in: 0..<2)
    }
}
