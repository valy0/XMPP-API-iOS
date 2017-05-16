//
//  UpdateUserCommand.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 5/3/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import XMPPFramework

class UpdateUserCommand: BaseCommand {

    // MARK: Initializers
    
    init(user: User) {
        super.init()
        
        self.command = .updateUser
        
        self.data[Parameters.lastName]  = user.lastName
        self.data[Parameters.firstName] = user.firstName
    }
    
    
    // MARK: Command Methods
    
    override func messageIsCommandResponse(_ message: XMPPMessage) -> Bool {
        return message.isLoginResponse
    }
    
    override var successAction: Selector? {
        return #selector(CommunicationDelegate.didUpdateUser)
    }
    
    override var failedAction: Selector? {
        return #selector(CommunicationDelegate.updateUserFailed(_:))
    }
}
