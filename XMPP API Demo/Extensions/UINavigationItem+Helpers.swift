//
//  UINavigationItem+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    // MARK: Public Methods
    
    func setMultilineTitle(_ title: String) {
        let fontSize: CGFloat    = 18.0
        let margin: CGFloat      = 4.0
        let screenWidth: CGFloat = UIScreen.width
        
        let titleView = UIView(frame: CGRect(x: screenWidth / 4,
                                             y: 0.0,
                                             width: screenWidth / 2,
                                             height: Constants.navigationBarHeight))
        
        let titleLabel = self.label(CGRect(x: 0.0,
                                           y: margin,
                                           width: titleView.frame.size.width,
                                           height: Constants.navigationBarHeight - (2 * margin)),
                                    text: title,
                                    fontSize: fontSize)
        
        titleLabel.numberOfLines  = 2
        titleView.backgroundColor = UIColor.clear
        
        titleView.addSubview(titleLabel)
        
        self.titleView = titleView
    }
    
    
    // MARK: Helpers
    
    private func textSize(_ text: NSString, fontSize: CGFloat) -> CGSize {
        return text.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: Constants.navigationBarHeight),
                                         options: [ .usesLineFragmentOrigin, .usesFontLeading ],
                                         attributes: [ NSFontAttributeName : UIFont.systemFont(ofSize:fontSize) ],
                                         context: nil).size
    }
    
    private func labelFrame(_ textSize: CGSize) -> CGRect {
        return CGRect(x: 0.0, y: 0.0, width: textSize.width, height: textSize.height)
    }
    
    private func label(_ frame: CGRect, text: String, fontSize: CGFloat) -> UILabel {
        let label = UILabel(frame: frame)
        
        label.text          = text
        label.textAlignment = .center
        
        return label
    }
}
