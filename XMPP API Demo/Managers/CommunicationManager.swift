//
//  CommunicationManager.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import Foundation
import XMPPFramework

class CommunicationManager: BaseManager, XMPPStreamDelegate {
    
    // MARK: Constants
    
    private let kCommunicationQueue = "com.vc.XMPP-API-Demo-Communication"
    
    
    // MARK: Variables
    
    private var _communicationQueue: DispatchQueue
    private var _delegates: MulticastDelegate<CommunicationDelegate>
    private var _sentCommands: [BaseCommand]
    
    
    // MARK: Singleton
    
    static let shared = CommunicationManager()
    
    
    // MARK: Initializers
    
    override init() {
        _sentCommands       = []
        _delegates          = MulticastDelegate<CommunicationDelegate>()
        _communicationQueue = DispatchQueue(label: kCommunicationQueue, qos: .`default`, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        
        super.init()
        
        self.additionalInitialization()
    }
    
    
    // MARK: Public Methods
    
    func addDelegate<T: AnyObject>(_ delegate: T) where T: CommunicationDelegate {
        _communicationQueue.sync {
            _delegates += delegate
        }
    }
    
    func removeDelegate<T: AnyObject>(_ delegate: T) where T: CommunicationDelegate {
        _communicationQueue.sync {
            _delegates -= delegate
        }
    }
    
    func didReceiveResponseForCommand(_ command: BaseCommand) {
        self.handleResponse(command.response ?? [:], successAction: command.successAction!, successData: command.onSuccessData, failAction: command.failedAction!)
        
        guard let indexOfCommandToDelete = _sentCommands.index(of: command) else {
            return
        }
        
        _sentCommands.remove(at: indexOfCommandToDelete)
    }
    
    func commandTimedOut(_ command: BaseCommand) {
        self.notifyDelegates(selector: command.failedAction!, object: Response.timeoutErrorForCommand(command.command.rawValue))
        
        guard let indexOfCommandToDelete = _sentCommands.index(of: command) else {
            return
        }
        
        _sentCommands.remove(at: indexOfCommandToDelete)
    }
    
    
    // MARK: Component Commands
    
    class func login(username: String, password: String) {
        self.sendCommand(LoginCommand(username: username, password: password))
    }
    
    class func logout() {
        self.sendCommand(LogoutCommand())
    }
    
    class func updateUser(_ user: User) {
        self.sendCommand(UpdateUserCommand(user: user))
    }
    
    class func updatePushData(ofUser userId: Int, withToken pushToken: String) {
        self.sendCommand(UpdatePushDataCommand(pushToken: pushToken, userId: userId))
    }
    
    class func getNotes() {
        self.sendCommand(GetNotesCommand())
    }
    
    class func addNote(_ note: Note) {
        self.sendCommand(AddNoteCommand(note: note))
    }
    
    class func updateNote(_ note: Note) {
        self.sendCommand(UpdateNoteCommand(note: note))
    }
    
    class func deleteNote(_ note: Note) {
        self.sendCommand(DeleteNoteCommand(note: note))
    }
    
    
    // MARK: XMPPStream Delegate
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        self.notifyDelegates(selector: #selector(CommunicationDelegate.didAuthenticate), object: nil)
    }
    
    func xmppStream(_ sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        Logger.log("Could not authenticate XMPP user")
        self.notifyDelegates(selector: #selector(CommunicationDelegate.xmppAuthFailed), object: nil)
    }
    
    func xmppStream(_ sender: XMPPStream!, didReceive message: XMPPMessage!) {
        if message.forName(Parameters.delay) != nil {
             // Ignore offline messages
            return
        }
        
        if message.isErrorMessage() {
            ApplicationManager.shared.networkActivityDidFinish()
            return
        }
    }
    
    
    // MARK: Private Methods
    
    private class func sendCommand(_ command: BaseCommand) {
        CommunicationManager.shared.sendCommand(command)
    }
    
    private func sendCommand(_ command: BaseCommand) {
        _sentCommands.append(command)
        command.send()
    }
    
    private func additionalInitialization() {
        XMPPManager.shared.xmppStream?.addDelegate(self, delegateQueue: _communicationQueue)
    }
    
    
    // MARK: Helpers
    
    private func handleResponse(_ response: NSDictionary, successAction: Selector, successData: Any?, failAction: Selector) {
        if (self.responseIsOk(response)) {
            self.notifyDelegates(selector: successAction, object: successData)
            return
        }
        
        self.notifyDelegates(selector: failAction, object: Response.errorFromResponse(response))
    }
    
    private func notifyDelegates(selector: Selector, object: Any?) {
        ApplicationManager.shared.networkActivityDidFinish()
        
        _communicationQueue.sync {
            for delegate in _delegates.allDelegates() {
                if !delegate.responds(to: selector) {
                    continue
                }
                
                typealias function = @convention(c) (AnyObject, Selector, Any?) -> Void
                let implementation = unsafeBitCast(delegate.method(for: selector), to: function.self)
                
                DispatchQueue.main.async {
                    implementation(delegate, selector, object)
                }
            }
        }
    }
    
    private func responseIsOk(_ response: NSDictionary) -> Bool {
        guard let status = response[Parameters.status] as? Int else {
            return false
        }
        
        return status == Response.Status.success.rawValue
    }
}
