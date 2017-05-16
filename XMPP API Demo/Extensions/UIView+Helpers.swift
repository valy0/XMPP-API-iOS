//
//  UIView+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: Public Methods
    
    
    func updateXorigin(_ xOrigin: CGFloat) {
        self.frame = CGRect(x: xOrigin, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    func updateYorigin(_ yOrigin: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: yOrigin, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    func updateWidth(_ width: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.size.height)
    }
    
    func updateHeight(_ height: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: height)
    }
    
    func addLoginTextFieldsShadow() {
        self.addShadow(1.0, height: 1.0, opacity: 0.8, radius: 1.0)
    }
    
    func addShadow(_ width: CGFloat, height: CGFloat, opacity: Float, radius: CGFloat) {
        self.layer.shadowColor   = UIColor.gray.cgColor
        self.layer.shadowOffset  = CGSize(width: width, height: height)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius  = radius
    }
    
    class func separatorView() -> UIView {
        return SeparatorView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.width, height: Constants.separatorHeight))
    }
    
    func show() {
        self.showAnimated(.none)
    }
    
    func showAnimated() {
        self.showAnimated(.default)
    }
    
    func showAnimated(_ duration: AnimationDuration) {
        self.animateAlpaChange(1.0, duration: duration)
    }
    
    func hide() {
        self.hideAnimated(.none)
    }
    
    func hideAnimated() {
        self.hideAnimated(.default)
    }
    
    func hideAnimated(_ duration: AnimationDuration) {
        self.animateAlpaChange(0.0, duration: duration)
    }
    
    func removeAnimated() {
        self.removeAnimated(.default)
    }
    
    func removeAnimated(_ duration: AnimationDuration) {
        let animations = {
            self.alpha = 0.0
        }
        
        let completion: ((Bool) -> Void) = { _ in
            self.removeFromSuperview()
        }
        
        if duration == .none {
            animations()
            completion(true)
            return
        }
        
        UIView.animate(withDuration: duration.rawValue, animations: animations, completion: completion)
    }
    
    func roundAllCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func roundTopCorners(_ radius: CGFloat) {
        self.roundCorners([.topLeft, .topRight], radius: radius)
    }
    
    func roundBottomCorners(_ radius: CGFloat) {
        self.roundCorners([.bottomLeft, .bottomRight], radius: radius)
    }
    
    func addBottomBorder() {
        let borderLayer             = CALayer()
        borderLayer.backgroundColor = UIColor.separatorColor.cgColor
        borderLayer.frame           = CGRect(x: 0.0,
                                             y: self.bounds.size.height - Constants.separatorHeight,
                                             width: self.bounds.size.width,
                                             height: Constants.separatorHeight)
        
        self.layer.addSublayer(borderLayer)
    }
    
    
    // MARK: Private Methods
    
    private func animateAlpaChange(_ alpha: CGFloat, duration: AnimationDuration) {
        let animations = {
            self.alpha = alpha
        }
        
        duration == .none ? animations () : UIView.animate(withDuration: duration.rawValue, animations: animations)
    }
    
    private func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer   = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path  = maskPath.cgPath
        
        self.layer.mask = maskLayer
    }
}
