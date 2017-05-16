//
//  UIBarButtonItem+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // MARK: Public Methods
    
    class func addButton(_ target: AnyObject?, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .add, target: target, action: action)
    }
    
    class func sendButton(_ target: AnyObject?, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: NSLocalizedString("Send", comment: "Bar Button Item"), style: .plain, target: target, action: action)
    }
    
    class func activityBarButton() -> UIBarButtonItem {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        let barButtonItem     = UIBarButtonItem(customView: activityIndicator)
        
        activityIndicator.startAnimating()
        
        return barButtonItem
    }
    
    class func saveButton(_ target: AnyObject?, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: NSLocalizedString("Save", comment: "Bar Button Item"), style: .plain, target: target, action: action)
    }
    
}
