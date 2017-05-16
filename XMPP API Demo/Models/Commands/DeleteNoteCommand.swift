//
//  DeleteNoteCommand.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 5/3/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import XMPPFramework

class DeleteNoteCommand: BaseCommand {

    // MARK: Initializers
    
    init(note: Note) {
        super.init()
        
        self.command = .deleteNote
        
        self.data[Parameters.id] = note.id
    }
    
    
    // MARK: Command Methods
    
    override func messageIsCommandResponse(_ message: XMPPMessage) -> Bool {
        return message.isDeleteNoteResponse
    }
    
    override var successAction: Selector? {
        return #selector(CommunicationDelegate.didDeleteNote)
    }
    
    override var failedAction: Selector? {
        return #selector(CommunicationDelegate.deleteNoteFailed(_:))
    }
}
