//
//  GetNotesCommand.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 5/3/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import XMPPFramework

class GetNotesCommand: BaseCommand {

    // MARK: Initializers
    
    override init() {
        super.init()
        
        self.command = .getNotes
    }
    
    
    // MARK: Command Methods
    
    override func messageIsCommandResponse(_ message: XMPPMessage) -> Bool {
        return message.isGetNotesResponse
    }
    
    override var successAction: Selector? {
        return #selector(CommunicationDelegate.didGetNotes(_:))
    }
    
    override var failedAction: Selector? {
        return #selector(CommunicationDelegate.getNotesFailed(_:))
    }
    
    override var onSuccessData: Any? {
        assert(self.response != nil, "Response is nil")
        
        return Note.notesFromResponse(self.response!)
    }
}
