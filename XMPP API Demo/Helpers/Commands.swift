//
//  Commands.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

enum Command: Int {
    
    case unknown        = -1
    case login          = 1
    case logout         = 2
    case updateUser     = 3
    case updatePushData = 4
    case getNotes       = 5
    case addNote        = 6
    case updateNote     = 7
    case deleteNote     = 8
}
