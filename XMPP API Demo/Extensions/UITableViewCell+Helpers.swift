//
//  UITableViewCell+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func removeSeparatorInsets() {
        // Remove seperator inset
        self.separatorInset = UIEdgeInsets.zero
        
        // Prevent the cell from inheriting the Table View's margin settings
        self.preservesSuperviewLayoutMargins = false
        
        // Explictly set your cell's layout margins
        self.layoutMargins = UIEdgeInsets.zero
    }
}
