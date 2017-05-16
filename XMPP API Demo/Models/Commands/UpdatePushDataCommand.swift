//
//  UpdatePushDataCommand.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 5/3/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import XMPPFramework

class UpdatePushDataCommand: BaseCommand {

    // MARK: Initializers
    
    init(pushToken: String, userId: Int) {
        super.init()
        
        self.command = .updatePushData
        
        self.data[Parameters.id]    = userId
        self.data[Parameters.token] = pushToken
    }
    
    
    // MARK: Command Methods
    
    override func messageIsCommandResponse(_ message: XMPPMessage) -> Bool {
        return message.isUpdatePushDataResponse
    }
    
    override var successAction: Selector? {
        return #selector(CommunicationDelegate.didUpdatePushData)
    }
    
    override var failedAction: Selector? {
        return #selector(CommunicationDelegate.updatePushDataFailed(_:))
    }
}
