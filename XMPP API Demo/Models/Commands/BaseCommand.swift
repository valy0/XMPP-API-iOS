//
//  BaseCommand.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import Foundation
import XMPPFramework

class BaseCommand: NSObject, XMPPStreamDelegate {

    // MARK: Variables
    
    private var _hasTimedOut: Bool
    private var _queue: DispatchQueue
    private var _timer: Timer?
    internal var response: NSDictionary?
    internal var command: Command
    internal var data: [String : Any]
    
    
    // MARK: Constants
    
    private let kTimeout: TimeInterval = 30.0
    private let kQueueName: String = "com.vc.XMPP-API-Demo-command"
    
    
    // MARK: De/Initializers
    
    override init() {
        command      = .unknown
        data         = [:]
        _hasTimedOut = false
        _queue       = DispatchQueue(label: kQueueName,  qos: .`default`, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        
        super.init()
        self.customInit()
    }
    
    deinit {
        XMPPManager.shared.xmppStream?.removeDelegate(self, delegateQueue: _queue)
        
        self.stopTimer()
    }
    
    
    // MARK: XMPP Stream Delegate
    
    func xmppStream(_ sender: XMPPStream!, didReceive message: XMPPMessage!) {
        if message.forName(Parameters.delay) != nil {
            // Ignore offline messages
            return
        }

        
        if !self.messageIsCommandResponse(message) {
            return
        }
        
        self.handleResponseMessage(message)
    }
    
    
    // MARK: Public Methods
    
    func send() {
        _hasTimedOut = false
        
        if self.startTimer {
            _timer = Timer.scheduledTimer(timeInterval: kTimeout, target: self, selector: #selector(didTimeout), userInfo: nil, repeats: false)
        }
        
        self.sendCommand(command, data: data)
    }
    
    func stopTimer() {
        guard let timer = _timer else {
            return
        }
        
        if timer.isValid {
            timer.invalidate()
        }
        
        _timer = nil
    }
    
    
    // MARK: Abstract Command Methods
    
    func messageIsCommandResponse(_ message: XMPPMessage) -> Bool {
        assert(false, "Abstract method not implemented \(#function)")
        return false
    }
    
    var number: Int {
        return command.rawValue
    }
    
    var successAction: Selector? {
        assert(false, "Abstract method not implemented \(#function)")
        return nil
    }
    
    var failedAction: Selector? {
        assert(false, "Abstract method not implemented \(#function)")
        return nil
    }
    
    var onSuccessData: Any? {
        return nil
    }
    
    var startTimer: Bool {
        return true
    }
    
    func handleResponseMessage(_ message: XMPPMessage) {
        self.response = message.response
        
        self.stopTimer()
        CommunicationManager.shared.didReceiveResponseForCommand(self)
    }
    
    
    // MARK: Private Methods
    
    private func customInit() {
        XMPPManager.shared.xmppStream?.addDelegate(self, delegateQueue: _queue)
    }
    
    private func sendCommand(_ command: Command, data: [String : Any]) {
        self.sendMessage(XMPPJID.componentJID, command: command, body: self.bodyForCommand(command, data: data)!)
    }
    
    private func sendMessage(_ receiver: XMPPJID, command: Command, body: String) {
        let message = XMPPMessage.chatMessage(receiver, subject: command.rawValue, body: body)
        
        ApplicationManager.shared.networkActivityDidStart()
        XMPPManager.shared.xmppStream?.send(message)
    }
    
    @objc private func didTimeout() {
        Logger.log("Command \(self.command) timed out with data: \(self.data)")
        _hasTimedOut = true
        
        self.stopTimer()
        CommunicationManager.shared.commandTimedOut(self)
    }
    
    
    // MARK: Helpers
    
    private func bodyForCommand(_ command: Command, data: [String : Any]) -> String? {
        let json = NSDictionary.requestForCommand(command.rawValue, extraData: data)
        var data: Data?
        
        do {
            data = try JSONSerialization.data(withJSONObject: json, options: [])
            return String(data: data!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            Logger.log("Could not parse message body from JSON to string. Error: \(error)")
            return nil
        }
    }
}
