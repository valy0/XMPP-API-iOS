//
//  SessionManager.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

class SessionManager: BaseManager {

    // MARK: Variables
    
    private(set) var user: User?
    
    
    // MARK: Singleton
    
    static let shared = SessionManager()
    
    
    // MARK: Public Methods
    
    func saveUser(_ newUser: User?) {
        self.user = newUser
    }
}
