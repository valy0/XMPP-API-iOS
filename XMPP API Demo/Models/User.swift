//
//  User.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 5/3/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

class User: BaseModel {

    // MARK: Properties
    
    private(set) var email: String     = ""
    private(set) var session: String   = ""
    private(set) var lastName: String  = ""
    private(set) var firstName: String = ""
    
    
    // MARK: Initializers
    
    override init(json: NSDictionary) {
        self.email     = json[Parameters.email]     as? String ?? ""
        self.session   = json[Parameters.session]   as? String ?? ""
        self.lastName  = json[Parameters.lastName]  as? String ?? ""
        self.firstName = json[Parameters.firstName] as? String ?? ""
        
        super.init(json: json)
    }
    
    
    // MARK: NSObject
    
    override var description: String {
        var desc: String = "User {\n"
        desc += "\tid = \(self.id)\n"
        desc += "\tfirst name = \(self.firstName)\n"
        desc += "\tlast name = \(self.lastName)\n"
        desc += "\temail = \(self.email)\n"
        desc += "\tsession = \(self.session)\n"
        desc += "}"
        return desc
    }
    
    override var debugDescription: String {
        return description
    }
}
