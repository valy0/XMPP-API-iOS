//
//  UITableView+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension UITableView {
    
    func headerView(height: CGFloat, sectionTitle: String, fontSize: CGFloat) -> UIView {
        let insets: CGFloat       = 16.0
        let labelHeight: CGFloat = 18.0
        
        let headerView = UIView(frame: CGRect(x: 0.0,
                                              y: 12.0,
                                              width: self.bounds.size.width,
                                              height: height))
        
        let headerLabel = UILabel(frame: CGRect(x: insets,
                                                y: headerView.bounds.size.height - (insets / 2) - labelHeight,
                                                width: headerView.bounds.size.width - (2 * insets),
                                                height: labelHeight))
        
        headerView.backgroundColor = self.backgroundColor
        
        headerLabel.text = sectionTitle
        
        let separatorView = UIView(frame: CGRect(x: 0.0,
                                                 y: headerView.bounds.size.height - Constants.separatorHeight,
                                                 width: headerView.bounds.size.width,
                                                 height: Constants.separatorHeight))
        separatorView.backgroundColor = UIColor.separatorColor
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(separatorView)
        
        return headerView
    }
    
    func removeTopInset() {
        var insets = self.contentInset
        insets.top = 0.0
        
        self.contentInset = insets
    }
}
