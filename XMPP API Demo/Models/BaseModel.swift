//
//  BaseModel.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import Foundation

class BaseModel: NSObject {
    
    // MARK: Properties
    
    private(set) var id: Int = 0
    
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    init(json: NSDictionary) {
        self.id = json[Parameters.id] as? Int ?? 0
        
        super.init()
    }
}
