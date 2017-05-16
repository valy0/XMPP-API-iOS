//
//  ApplicationManager.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import CocoaLumberjack
import LocalAuthentication

class ApplicationManager: BaseManager {
    
    // MARK: Private Variables
    
    private var _processingCommands = 0
    
    
    // MARK: Singleton
    
    static let shared = ApplicationManager()
    
    
    // MARK: Public Methods
    
    func prepareApp(_ application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Setup secure user defaults
        UserDefaults.setDeviceData()
        
        // Setup XMPP
        XMPPManager.shared.setupStream()
        
        // Log traffic
        DDLog.add(DDTTYLogger.sharedInstance, with: Constants.logLevel)
    
        // Register for Push Notifications
        NotificationManager.shared.registerForPushNotifications()

        // Handle possible launch from notification
        
        if let notification = launchOptions?[.remoteNotification] {
            guard let notification = notification as? NSNotification else {
                return true
            }
            
            guard let userInfo = notification.userInfo else {
                return true
            }
            
            NotificationManager.shared.handleNotification(userInfo)
        }
        
        return true
    }
    
    func networkActivityDidStart() {
        _processingCommands += 1;
        updateNetworkActivityIndocator();
    }
    
    func networkActivityDidFinish() {
        _processingCommands -= 1;
        updateNetworkActivityIndocator();
    }
    
    
    // MARK: Private Methods
    
    private func updateNetworkActivityIndocator() {
        if _processingCommands < 0 {
            _processingCommands = 0
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = _processingCommands > 0
    }
}
