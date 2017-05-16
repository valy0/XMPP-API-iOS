//
//  UpdateNoteCommand.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 5/3/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import XMPPFramework

class UpdateNoteCommand: BaseCommand {

    // MARK: Initializers
    
    init(note: Note) {
        super.init()
        
        self.command = .updateNote
        
        self.data[Parameters.id]      = note.id
        self.data[Parameters.title]   = note.title
        self.data[Parameters.content] = note.content
    }
    
    
    // MARK: Command Methods
    
    override func messageIsCommandResponse(_ message: XMPPMessage) -> Bool {
        return message.isUpdateNoteResponse
    }
    
    override var successAction: Selector? {
        return #selector(CommunicationDelegate.didUpdateNote)
    }
    
    override var failedAction: Selector? {
        return #selector(CommunicationDelegate.updateNoteFailed(_:))
    }
}
