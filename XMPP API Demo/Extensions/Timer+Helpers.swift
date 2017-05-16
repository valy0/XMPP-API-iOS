//
//  Timer+Helpers.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

extension Timer {
    
    static func performSelector(_ selector: Selector, at target: Any, withObject userInfo: Any?, afterDelay delay: TimeInterval) {
        Timer.scheduledTimer(timeInterval: delay, target: target, selector: selector, userInfo: userInfo, repeats: false)
    }
}
