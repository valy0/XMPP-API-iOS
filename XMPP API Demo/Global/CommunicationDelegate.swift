//
//  CommunicationDelegate.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

@objc
protocol CommunicationDelegate {
    
    // MARK: XMPP delegates
    
    @objc optional func didAuthenticate()
    @objc optional func xmppAuthFailed()
    
    
    // MARK: Component delegate commands
    
    @objc optional func didLogin(user: User)
    @objc optional func loginFailed(_ error: NSError)
    
    @objc optional func didLogout()
    @objc optional func logoutFailed(_ error: NSError)
    
    @objc optional func didUpdateUser()
    @objc optional func updateUserFailed(_ error: NSError)
    
    @objc optional func didUpdatePushData()
    @objc optional func updatePushDataFailed(_ error: NSError)
    
    @objc optional func didGetNotes(_ notes: [Note])
    @objc optional func getNotesFailed(_ error: NSError)
    
    @objc optional func didAddNote(_ noteId: Int)
    @objc optional func addNoteFailed(_ error: NSError)
    
    @objc optional func didUpdateNote()
    @objc optional func updateNoteFailed(_ error: NSError)
    
    @objc optional func didDeleteNote()
    @objc optional func deleteNoteFailed(_ error: NSError)
}
