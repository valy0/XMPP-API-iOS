//
//  SeparatorView.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

class SeparatorView: UIView {
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.customInit()
    }
    

    // MARK: Private Methods
    
    private func customInit() {
        self.backgroundColor = UIColor.separatorColor
    }
}
