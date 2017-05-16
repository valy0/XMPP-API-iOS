//
//  NoteTableViewCell.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 5/16/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

class NoteTableViewCell: BasicTableViewCell {

    // MARK: Variables
    
    var note: Note? {
        didSet {
            self.updateUI()
        }
    }
    
    
    // MARK: Private Methods
    
    private func updateUI() {
        guard let note = self.note else {
            return
        }
        
        self.basicLabel.text = note.title
    }
}
