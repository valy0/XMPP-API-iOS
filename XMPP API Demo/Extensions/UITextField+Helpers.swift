//
//  UITextField+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit
import Foundation

extension UITextField {
    
    // MARK: Public Methods
    
    var isEmpty: Bool {
        guard let text = self.text else {
            return true
        }
        
        return text.trimmed.length == 0
    }
    
    func leftViewWithImage(_ imageName: String) {
        guard let image = UIImage(named: imageName) else {
            return
        }
        
        self.leftViewMode = .always
        self.leftView     = self.leftViewWithImage(image)
    }
    
    func rightViewWithImage(_ imageName: String) {
        guard let image = UIImage(named: imageName) else {
            return
        }
        
        self.rightViewMode = .always
        self.rightView     = UIImageView(image: image)
    }
    
    func leftViewWithText(_ text: String) {
        let kPadding: CGFloat  = 2.0
        let labelSize = (text as NSString).boundingRect(with: CGSize(width: self.bounds.size.width, height: self.bounds.size.height),
                                                                options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                attributes: [ NSFontAttributeName : UIFont.systemFont(ofSize: self.font!.pointSize) ],
                                                                context: nil).size
        
        let view  = UIView(frame: CGRect(x: 0.0, y: 0.0, width: labelSize.width + (2 * kPadding), height: self.bounds.size.height))
        let label = UILabel(frame: CGRect(x: kPadding, y: (view.bounds.size.height - labelSize.height - kPadding) / 2, width: labelSize.width, height: labelSize.height))
        
        label.text              = text
        label.textAlignment     = .center
        label.backgroundColor   = UIColor.clear
        label.lineBreakMode     = .byTruncatingTail
        
        view.addSubview(label)
        
        self.leftViewMode  = .always
        self.leftView      = view
    }
    
    func rightViewWithText(_ text: String) {
        let kPadding: CGFloat  = 2.0
        let labelSize = (text as NSString).boundingRect(with: CGSize(width: self.bounds.size.width, height: self.bounds.size.height),
                                                                options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                attributes: [ NSFontAttributeName : UIFont.systemFont(ofSize: self.font!.pointSize) ],
                                                                context: nil).size
        
        let view  = UIView(frame: CGRect(x: 0.0, y: 0.0, width: labelSize.width + (2 * kPadding), height: self.bounds.size.height))
        let label = UILabel(frame: CGRect(x: kPadding, y: (view.bounds.size.height - labelSize.height - kPadding) / 2, width: labelSize.width, height: labelSize.height))
        
        label.text              = text
        label.textAlignment     = .center
        label.backgroundColor   = UIColor.clear
        label.lineBreakMode     = .byTruncatingTail
        
        view.addSubview(label)
        
        self.rightViewMode  = .always
        self.rightView      = view
    }
    
    
    // MARK: Private Methods
    
    private func leftViewWithImage(_ image: UIImage) -> UIView {
        let leftView    = UIView(frame: CGRect(x: 0.0, y: 0.0, width: image.size.width + 4.0, height: image.size.height))
        let imageView   = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height))
        imageView.image = image
        
        leftView.addSubview(imageView)
        return leftView
    }
}
