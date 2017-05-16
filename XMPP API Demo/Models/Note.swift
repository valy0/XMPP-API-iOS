//
//  Note.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import Foundation

class Note: BaseModel {
    
    // MARK: Properties
    
    private(set) var title: String   = ""
    private(set) var content: String = ""
    
    
    // MARK: Initializers
    
    override init(json: NSDictionary) {
        self.title   = json[Parameters.title]   as? String ?? ""
        self.content = json[Parameters.content] as? String ?? ""
        
        super.init(json: json)
    }
    
    
    // MARK: Public Methods
    
    class func notesFromResponse(_ response: NSDictionary) -> [Note] {
        guard let notesData = response[Parameters.notes] as? [NSDictionary] else {
            return []
        }
        
        var notes: [Note] = []
        
        for noteData in notesData {
            notes.append(Note(json: noteData))
        }
        
        return notes
    }
    
    
    // MARK: NSObject
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let note = object as? Note else {
            return false
        }
        
        return note.id == self.id
    }
    
    override var description: String {
        var desc: String = "Note {\n"
        desc += "\tid = \(self.id)\n"
        desc += "\ttitle = \(self.title)\n"
        desc += "\tcontent = \(self.content)\n"
        desc += "}"
        return desc
    }
    
    override var debugDescription: String {
        return description
    }
}
