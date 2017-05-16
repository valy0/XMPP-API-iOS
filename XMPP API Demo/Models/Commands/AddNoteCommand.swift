//
//  AddNoteCommand.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 5/3/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import XMPPFramework

class AddNoteCommand: BaseCommand {

    // MARK: Initializers
    
    init(note: Note) {
        super.init()
        
        self.command = .addNote
        
        self.data[Parameters.title]   = note.title
        self.data[Parameters.content] = note.content
    }
    
    
    // MARK: Command Methods
    
    override func messageIsCommandResponse(_ message: XMPPMessage) -> Bool {
        return message.isGetNotesResponse
    }
    
    override var successAction: Selector? {
        return #selector(CommunicationDelegate.didAddNote(_:))
    }
    
    override var failedAction: Selector? {
        return #selector(CommunicationDelegate.addNoteFailed(_:))
    }
    
    override var onSuccessData: Any? {
        assert(self.response != nil, "Response is nil")
        
        return self.response?[Parameters.id]
    }
}
