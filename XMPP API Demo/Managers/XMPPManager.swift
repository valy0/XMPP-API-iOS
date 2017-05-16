//
//  XMPPManager.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import Foundation
import XMPPFramework

class XMPPManager: BaseManager, XMPPStreamDelegate {
    
    // MARK: Enumerators
    
    enum XMPPLog: Int32 {
        case send        = 5
        case receivePre  = 6 // Prints data before it goes to the parser
        case receivePost = 7 // Prints data as it comes out of the parser
    }
    

    // MARK: Singleton
    
    static let shared = XMPPManager()
    
    
    // MARK: Variables
    
    private(set) var isAuthenticated = false
    private(set) var isXmppConnected = false
    private(set) var xmppStream: XMPPStream?
    private(set) var xmppReconnect: XMPPReconnect?
    private(set) var xmppDeliveryReceipt: XMPPMessageDeliveryReceipts?
    
    private var _hasInternetConnection = false
    private var _customCertEvaluation = false
    private var _username = ""
    private var _password = ""
    
    
    // MARK: Public Methods
    
    func connect(_ username: String, password: String) -> Bool {
        if isXmppConnected {
            self.disconnect()
        }
        
        if !(xmppStream?.isDisconnected())! {
            return true
        }
        
        if (username.characters.count == 0 || password.characters.count == 0) {
            return false
        }
        
        Logger.log("Logging in with credentials: \(username)/\(password)")
        
        xmppStream?.myJID = XMPPJID(string: username, resource: Constants.xmppResource)
        
        _username = username;
        _password = password;
        
        do {
            try xmppStream?.connect(withTimeout: XMPPStreamTimeoutNone)
        } catch let error as NSError {
            Logger.log("Error connecting: \(error)")
            return false
        }
        
        return true
    }
    
    func setupStream() {
        assert(xmppStream == nil, "Method setupStream invoked multiple times")
        
        xmppStream = XMPPStream()
        
        if Platform.isSimulator {
            // Want xmpp to run in the background?
            //
            // P.S. - The simulator doesn't support backgrounding yet.
            //        When you try to set the associated property on the simulator, it simply fails.
            //        And when you background an app on the simulator,
            //        it just queues network traffic til the app is foregrounded again.
            //        We are patiently waiting for a fix from Apple.
            //        If you do enableBackgroundingOnSocket on the simulator,
            //        you will simply see an error message from the xmpp stack when it fails to set the property.
            
            xmppStream!.enableBackgroundingOnSocket = true
        }
        
        // Setup reconnect
        //
        // The XMPPReconnect module monitors for "accidental disconnections" and
        // automatically reconnects the stream for you.
        // There's a bunch more information in the XMPPReconnect header file.
        
        xmppReconnect = XMPPReconnect()
        xmppReconnect!.autoReconnect = true
        
        xmppDeliveryReceipt = XMPPMessageDeliveryReceipts()
        xmppDeliveryReceipt?.autoSendMessageDeliveryReceipts = true
        
        // Activate xmpp modules
        xmppReconnect!.activate(xmppStream)
        xmppDeliveryReceipt!.activate(xmppStream)
        
        // Add ourself as a delegate to anything we may be interested in
        xmppStream?.addDelegate(self, delegateQueue: DispatchQueue.main)
        
        xmppStream?.hostName = Constants.xmppServer
        xmppStream?.hostPort = Constants.xmppPort
        
        // You may need to alter these settings depending on the server you're connecting to.
        _customCertEvaluation = true;
    }
    
    func teardownStream() {
        xmppStream?.removeDelegate(self)
        xmppReconnect?.deactivate()
        xmppStream?.disconnect()
        
        xmppStream     = nil;
        xmppReconnect  = nil;
    }
    
    func goOnline() {
        let presence = XMPPPresence(type: "available") // type="available" is implicit
        let domain = xmppStream?.myJID.domain
        
        // Google set their presence priority to 24, so we do the same to be compatible.
        if domain == "gmail.com" || domain == "gtalk.com" || domain == "talk.google.com" {
            let priority = DDXMLElement(name: "priority", stringValue: "24")
            presence?.addChild(priority)
        }
        
        xmppStream?.send(presence)
    }
    
    func goOffline() {
        let presence = XMPPPresence(type: "unavailable")
        
        xmppStream?.send(presence)
    }
    
    func disconnect() {
        self.goOffline()
        xmppStream?.disconnect()
    }
    
    
    // MARK: Connectivity
    
    func lostInternetConnection() {
        if _hasInternetConnection {
            self.goOffline()
        }
        
        _hasInternetConnection = false
    }
    
    func reEstablishedInternetConnection() {
        if !_hasInternetConnection {
            let _ = self.connect()
        }
        
        _hasInternetConnection = true
    }
    
    func checkConnection() {
        if !isAuthenticated {
            if !(self.connect()) {
                // In case we were not authenticated make sure to check again after 5 more seconds
                self.perform(#selector(XMPPManager.checkConnection), with: nil, afterDelay: 5)
            }
        }
    }
    
    
    // MARK: XMPPStream Delegate
    
    func xmppStream(_ sender: XMPPStream!, willSecureWithSettings settings: NSMutableDictionary!) {
        let expectedCertName = xmppStream?.myJID.domain
        
        if (expectedCertName != nil) {
            settings.setObject(expectedCertName!, forKey: kCFStreamSSLPeerName as String as String as NSCopying)
        }
        
        if _customCertEvaluation {
            settings.setObject(true, forKey: GCDAsyncSocketManuallyEvaluateTrust as NSCopying)
        }
    }
    
    /**
     * Allows a delegate to hook into the TLS handshake and manually validate the peer it's connecting to.
     *
     * This is only called if the stream is secured with settings that include:
     * - GCDAsyncSocketManuallyEvaluateTrust == YES
     * That is, if a delegate implements xmppStream:willSecureWithSettings:, and plugs in that key/value pair.
     *
     * Thus this delegate method is forwarding the TLS evaluation callback from the underlying GCDAsyncSocket.
     *
     * Typically the delegate will use SecTrustEvaluate (and related functions) to properly validate the peer.
     *
     * Note from Apple's documentation:
     *   Because [SecTrustEvaluate] might look on the network for certificates in the certificate chain,
     *   [it] might block while attempting network access. You should never call it from your main thread;
     *   call it only from within a function running on a dispatch queue or on a separate thread.
     *
     * This is why this method uses a completionHandler block rather than a normal return value.
     * The idea is that you should be performing SecTrustEvaluate on a background thread.
     * The completionHandler block is thread-safe, and may be invoked from a background queue/thread.
     * It is safe to invoke the completionHandler block even if the socket has been closed.
     *
     * Keep in mind that you can do all kinds of cool stuff here.
     * For example:
     *
     * If your development server is using a self-signed certificate,
     * then you could embed info about the self-signed cert within your app, and use this callback to ensure that
     * you're actually connecting to the expected dev server.
     *
     * Also, you could present certificates that don't pass SecTrustEvaluate to the client.
     * That is, if SecTrustEvaluate comes back with problems, you could invoke the completionHandler with NO,
     * and then ask the client if the cert can be trusted. This is similar to how most browsers act.
     *
     * Generally, only one delegate should implement this method.
     * However, if multiple delegates implement this method, then the first to invoke the completionHandler "wins".
     * And subsequent invocations of the completionHandler are ignored.
     **/
    
    func xmppStream(_ sender: XMPPStream!, didReceive trust: SecTrust!, completionHandler: ((Bool) -> Void)!) {
        // The delegate method should likely have code similar to this,
        // but will presumably perform some extra security code stuff.
        // For example, allowing a specific self-signed certificate that is known to the app.
        
        DispatchQueue.global(qos: .`default`).async {
            var result = SecTrustResultType.invalid
            let status = SecTrustEvaluate(trust, &result)
            
            completionHandler(status == noErr && (result == SecTrustResultType.proceed || result == SecTrustResultType.unspecified))
        }
    }
    
    func xmppStreamDidSecure(_ sender: XMPPStream!) {
        
    }
    
    func xmppStreamDidConnect(_ sender: XMPPStream!) {
        isXmppConnected = true
        
        do {
            try xmppStream?.authenticate(withPassword: _password)
        } catch let error as NSError {
            Logger.log("Error authenticating: \(error)")
        }
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        isAuthenticated = true
        _hasInternetConnection = true
        
        self.goOnline()
        self.enableStreamManagement()
    }
    
    func xmppStream(_ sender: XMPPStream!, didReceive iq: XMPPIQ!) -> Bool {
        return false
    }
    
    func xmppStream(_ sender: XMPPStream!, didReceiveError error: DDXMLElement!) {
        if error == nil {
            return
        }
        
        guard let _ = error.forName("conflict") else {
            return
        }
        
        guard let errorText = error.forName("text")?.stringValue else {
            return
        }
        
        if errorText != "Replaced by new connection" {
            return
        }
        
        // Someone logged in on a different device with the same JID and resource id
    }
    
    func xmppStreamDidDisconnect(_ sender: XMPPStream!, withError error: Error!) {
        if !isXmppConnected {
            Logger.log("Unable to connect to server. Check xmppStream.hostName")
        }
    }
    
    
    // MARK: Private Methods
    
    private func connect() -> Bool {
        return self.connect(_username, password: _password)
    }
    
    private func enableStreamManagement() {
        let enable = DDXMLElement(name: "enable")
        enable.addAttribute(withName: "xmlns", stringValue: XMPPExtension.StreamManagementExtension)
        
        xmppStream?.send(enable)
    }
}
