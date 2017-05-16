//
//  UIAlertController+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension UIAlertController: UITextFieldDelegate {
    
    typealias HandlerBlock = () -> Void
    
    
    // MARK: Alerts
    
    class func showErrorMessage(_ sender: UIViewController) {
        self.showErrorMessage(NSLocalizedString("An error occured. Please accept our appologies and try again later", comment: "Alert message"), sender: sender)
    }
    
    class func showErrorMessage(_ message: String, sender: UIViewController) {
        self.showErrorMessage(message, sender: sender, dismissAction: nil)
    }
    
    class func showEmptyFieldsErrorMessage(_ sender: UIViewController) {
        self.showErrorMessage(NSLocalizedString("Please fill all fields", comment: "Alert message"), sender: sender)
    }
    
    class func showInfo(_ message: String, sender: UIViewController, dismissAction: HandlerBlock?) {
        let okAction = self.okAction(sender, handler: dismissAction);
        
        self.showAlert(NSLocalizedString("XMPP API Demo", comment: "Alert title"), message: message, actions: [okAction], sender: sender)
    }
    
    class func showErrorMessage(_ message: String, sender: UIViewController, dismissAction: HandlerBlock?) {
        let okAction = self.okAction(sender, handler: dismissAction);
        
        self.showAlert(NSLocalizedString("XMPP API Demo", comment: "Alert title"), message: message, actions: [okAction], sender: sender)
    }
    
    class func showSuccessMessage(_ sender: UIViewController) {
        self.showSuccessMessage(sender, dismissAction: nil)
    }
    
    class func showSuccessMessage(_ message: String, sender: UIViewController, dismissAction: HandlerBlock?) {
        let okAction = self.okAction(sender, handler: dismissAction)
        
        self.showAlert(NSLocalizedString("XMPP API Demo", comment: "Alert title"), message: message, actions: [okAction], sender: sender)
    }
    
    class func showSuccessMessage(_ sender: UIViewController, dismissAction: HandlerBlock?) {
        let okAction = self.okAction(sender, handler: dismissAction)
        
        self.showAlert(NSLocalizedString("XMPP API Demo", comment: "Alert title"),
                       message: NSLocalizedString("Operation completed successfully", comment: "Alert message"),
                       actions: [okAction],
                       sender: sender)
    }
    
    
    // MARK: Private Methods
    
    private class func dismissAction(_ sender: UIViewController, handler: HandlerBlock?) -> UIAlertAction {
        return self.cancelAction(nil, sender: sender, handler: handler)
    }
    
    private class func okAction(_ sender: UIViewController, handler: HandlerBlock?) -> UIAlertAction {
        return self.cancelAction(NSLocalizedString("Ok", comment: "Alert action"), sender: sender, handler: handler)
    }
    
    private class func cancelAction(_ title: String?, sender: UIViewController, handler: HandlerBlock?) -> UIAlertAction {
        return self.alertAction(title ?? NSLocalizedString("Cancel", comment: "Alert action"), style: .cancel, sender: sender, handler: handler)
    }
    
    private class func alertAction(_ title: String, sender: UIViewController, handler: HandlerBlock?) -> UIAlertAction {
        return self.alertAction(title, style: .`default`, sender: sender, handler: handler)
    }
    
    private class func alertAction(_ title: String, style: UIAlertActionStyle, sender: UIViewController, handler: HandlerBlock?) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style) { (alertAction) in
            handler?()
        }
        
        return action
    }
    
    private class func showAlert(_ title: String?, message: String?, actions: [UIAlertAction], sender: UIViewController) {
        self.show(title, message: message, style: .alert, actions: actions, sender: sender)
    }
    
    private class func showActionSheet(_ title: String?, actions: [UIAlertAction], sender: UIViewController) {
        self.show(title, message: nil, style: .actionSheet, actions: actions, sender: sender)
    }
    
    
    // MARK: Helpers
    
    private class func show(_ title: String?, message: String?, style: UIAlertControllerStyle, actions: [UIAlertAction], sender: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if style == .actionSheet && !self.hasCancelAction(actions) {
            alertController.addAction(self.cancelAction(nil, sender: sender, handler: nil))
        }
        
        for action in actions {
            alertController.addAction(action)
        }
        
        sender.present(alertController, animated: true, completion: nil)
    }
    
    private class func hasCancelAction(_ actions: [UIAlertAction]) -> Bool {
        for action in actions {
            if action.style == .cancel {
                return true
            }
        }
        
        return false
    }
}
