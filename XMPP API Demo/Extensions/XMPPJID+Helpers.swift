//
//  XMPPJID+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import XMPPFramework

extension XMPPJID {
    
    // MARK: Public Methods
    
    static var componentJID: XMPPJID {
        return XMPPJID(string: "demo.\(Constants.xmppServer)")
    }
}
