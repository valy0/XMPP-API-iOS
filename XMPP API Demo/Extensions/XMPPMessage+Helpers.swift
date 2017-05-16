//
//  XMPPMessage+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import Foundation
import XMPPFramework

extension XMPPMessage {
    
    // MARK: Public Methods
    
    class func chatMessage(_ receiver: XMPPJID, subject: Int, body: String) -> XMPPMessage {
        let message = XMPPMessage(type: Parameters.chat, to: receiver, elementID: XMPPStream.generateUUID())!
        
        if let senderJID = XMPPManager.shared.xmppStream?.myJID {
            message.addSender(senderJID.full())
        }
        
        message.addSubject(String(subject))
        message.addBody(body)
        message.addLanguage(Constants.defaultLang)
        return message
    }
    
    var response: NSDictionary {
        do {
            return try JSONSerialization.jsonObject(with: self.body().data(using: String.Encoding.utf8)!, options: .allowFragments) as! NSDictionary
        } catch let error as NSError {
            Logger.log("Failed to parse message body to JSON object, Body: \(self.body()).\nError: \(error)")
            return [:]
        }
    }
    
    var isLoginResponse: Bool          { return self.isResponseOf(.login) }
    var isLogoutResponse: Bool         { return self.isResponseOf(.logout) }
    var isUpdateUserResponse: Bool     { return self.isResponseOf(.updateUser) }
    var isUpdatePushDataResponse: Bool { return self.isResponseOf(.updatePushData) }
    var isGetNotesResponse: Bool       { return self.isResponseOf(.getNotes) }
    var isAddNoteResponse: Bool        { return self.isResponseOf(.addNote) }
    var isUpdateNoteResponse: Bool     { return self.isResponseOf(.updateNote) }
    var isDeleteNoteResponse: Bool     { return self.isResponseOf(.deleteNote) }
    
    
    // MARK: Private Methods
    
    private func addSender(_ sender: String) {
        self.addAttribute(withName: Parameters.from, stringValue: sender)
    }
    
    private func addLanguage(_ lang: String) {
        self.addAttribute(withName: Parameters.lang, stringValue: lang)
    }
    
    
    // MARK: Helpers
    
    private func isResponseOf(_ command: Command) -> Bool {
        return self.subject().intValue == command.rawValue
    }
}
