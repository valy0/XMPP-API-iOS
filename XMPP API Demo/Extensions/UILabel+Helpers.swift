//
//  UILabel+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension UILabel {
    
    // MARK: Public Methods
    
    func exactHeightForWidth(_ width: Double) -> CGFloat {
        return self.exactSize(width, height: Double.greatestFiniteMagnitude).height
    }
    
    func exactWidthForHeight(_ height: Double) -> CGFloat {
        return self.exactSize(Double.greatestFiniteMagnitude, height: height).width
    }
    
    
    // MARK: Private Methods
    
    func exactSize(_ width: Double, height: Double) -> CGSize {
        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        return (self.text! as NSString).boundingRect(with: CGSize(width: width, height: height),
                                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                            attributes: [
                                                                NSFontAttributeName : self.font,
                                                                NSParagraphStyleAttributeName : paragraphStyle
                                                            ],
                                                            context: nil).size
    }
}
