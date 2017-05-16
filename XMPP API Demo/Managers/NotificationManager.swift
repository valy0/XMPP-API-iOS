//
//  NotificationManager.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

class NotificationManager: BaseManager, CommunicationDelegate {

    // MARK: Singleton
    
    static let shared = NotificationManager()
    private var token: String = ""
    
    
    // MARK: Initializers
    
    override init() {
        super.init()
        
        CommunicationManager.shared.addDelegate(self)
    }
    
    deinit {
        CommunicationManager.shared.removeDelegate(self)
    }
    
    
    // MARK: Communication Delegate
    
    func didLogin(user: User) {
        if self.token.length == 0 {
            return
        }
        
        CommunicationManager.updatePushData(ofUser: user.id, withToken: self.token)
    }
    
    
    // MARK: Public Methods
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            Logger.log("Did reuqest to send notifications with results:\nGranted: \(granted).\nError: \(error?.localizedDescription ?? "N/A")")
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func savePushToken(_ pushToken: Data) {
        for i in 0..<pushToken.count {
            self.token = self.token + String(format: "%02.2hhx", arguments: [pushToken[i]])
        }
        
        Logger.log("TOKEN: \(self.token)")
    }
    
    func handleNotification(_ notification: [AnyHashable : Any]) {
        Logger.log("Received notification: \(notification)")
        
        guard let aps = notification["aps"] as? NSDictionary else {
            return
        }
        
        guard let message = aps["alert"] as? String else {
            return
        }
        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        let alertController = UIAlertController(title: NSLocalizedString("XMPP API Demo", comment: "Alert title"), message: message, preferredStyle: .alert)
        let okAction        = UIAlertAction(title: NSLocalizedString("Ok", comment: "Alert action"), style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
