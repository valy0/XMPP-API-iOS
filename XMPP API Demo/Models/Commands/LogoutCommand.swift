//
//  LogoutCommand.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import XMPPFramework

class LogoutCommand: BaseCommand {
    
    // MARK: Initializers
    
    override init() {
        super.init()
        
        self.command = .logout
    }
    
    
    // MARK: Command Methods
    
    override func messageIsCommandResponse(_ message: XMPPMessage) -> Bool {
        return message.isLogoutResponse
    }
    
    override var successAction: Selector? {
        return #selector(CommunicationDelegate.didLogout)
    }
    
    override var failedAction: Selector? {
        return #selector(CommunicationDelegate.logoutFailed(_:))
    }
    
    override var startTimer: Bool {
        return false
    }
}
