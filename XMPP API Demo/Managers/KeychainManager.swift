//
//  KeychainManager.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import SAMKeychain

class KeychainManager: BaseManager {
    
    // Services
    private let kUser = "user"
    
    // Accounts
    private let kUsername = "username"
    private let kPassword = "password"

    
    // MARK: Singleton

    static let shared = KeychainManager()
    
    
    // MARK: Public Methods
    
    func resetKeychain() {
        Logger.log("Resetting keychain...")
        
        self.deleteUserData()
    }
    
    
    // MARK: Setters
    
    func saveCredentials(_ username: String, password: String) {
        self.saveDataToKeychain(username, service: kUser, account: kUsername)
        self.saveDataToKeychain(password, service: kUser, account: kPassword)
    }
    
    func changePassword(_ password: String) {
        self.saveDataToKeychain(password, service: kUser, account: kPassword)
    }
    
    
    // MARK: Getters
    
    var username: String {
        return self.dataFromKeychain(kUser, account: kUsername)
    }
    
    var password: String {
        return self.dataFromKeychain(kUser, account: kPassword)
    }
    
    
    // MARK: Private Methods
    
    private func dataFromKeychain(_ service: String, account: String) -> String {
        var error: NSError?
        let data = SAMKeychain.password(forService: service, account: account, error: &error)
        
        if (error != nil) {
            Logger.log("Error while fetching \(service) from keychain: \(error?.localizedDescription ?? "N/A")")
            return ""
        }
        
        return data ?? ""
    }
    
    private func saveDataToKeychain(_ data: String, service: String, account: String) {
        assert(data.characters.count > 0, "Tring to save empty service '\(service)' in keychain.")
        
        var error: NSError?
        let saved = SAMKeychain.setPassword(data, forService: service, account: account, error: &error)
        
        assert(error == nil || !saved, "Failed to save '\(service)' with value '\(data)' in account '\(account)' to keychain. Error: \(error?.localizedDescription ?? "N/A")")
    }
    
    private func deleteUserData() {
        SAMKeychain.deletePassword(forService: kUser, account: kUsername)
        SAMKeychain.deletePassword(forService: kUser, account: kPassword)
    }
}
