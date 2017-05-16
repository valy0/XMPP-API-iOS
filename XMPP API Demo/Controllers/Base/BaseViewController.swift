//
//  BaseViewController.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 5/16/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController, CommunicationDelegate {

    // MARK: Controller Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CommunicationManager.shared.addDelegate(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        CommunicationManager.shared.removeDelegate(self)
        
        super.viewWillDisappear(animated)
    }
    
    
    // MARK: Public Methods
    
    func localize() {
        
    }
    
    func goBack() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func showLoadingHUD() {
        self.hideLoadingHUD()
        
        if let view = self.navigationController?.view {
            MBProgressHUD.showAdded(to: view, animated: true)
            return
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideLoadingHUD() {
        if let view = self.navigationController?.view {
            MBProgressHUD.hideAllHUDs(for: view, animated: true)
            return
        }
        
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }
    
    @nonobjc func requestFailed(_ error: NSError) {
        self.requestFailed(error, dismissHandler: nil)
    }
    
    func requestFailed(_ error: NSError, dismissHandler: (() -> Void)?) {
        self.hideLoadingHUD()
        
        Logger.log("Communication error: \(error)")
        
        UIAlertController.showErrorMessage(error.localizedDescription, sender: self)
    }
    
    
    // MARK: Communication Delegate
    
    func loginFailed(_ error: NSError)          { self.requestFailed(error) }
    func logoutFailed(_ error: NSError)         { self.requestFailed(error) }
    func updateUserFailed(_ error: NSError)     { self.requestFailed(error) }
    func updatePushDataFailed(_ error: NSError) { self.requestFailed(error) }
    func getNotesFailed(_ error: NSError)       { self.requestFailed(error) }
    func addNoteFailed(_ error: NSError)        { self.requestFailed(error) }
    func updateNoteFailed(_ error: NSError)     { self.requestFailed(error) }
    func deleteNoteFailed(_ error: NSError)     { self.requestFailed(error) }
}
