//
//  LoginCommand.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import XMPPFramework

class LoginCommand: BaseCommand {

    // MARK: Initializers
    
    init(username: String, password: String) {
        super.init()
        
        self.command = .login
        
        self.data[Parameters.email]    = username
        self.data[Parameters.password] = password
    }
    
    
    // MARK: Command Methods
    
    override func messageIsCommandResponse(_ message: XMPPMessage) -> Bool {
        return message.isLoginResponse
    }
    
    override var successAction: Selector? {
        return #selector(CommunicationDelegate.didLogin(user:))
    }
    
    override var failedAction: Selector? {
        return #selector(CommunicationDelegate.loginFailed(_:))
    }
    
    override var onSuccessData: Any? {
        assert(self.response != nil, "Response is nil")
        
        return User(json: self.response!)
    }
}
