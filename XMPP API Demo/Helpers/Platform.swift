//
//  Platform.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import Foundation

struct Platform {
    static let isSimulator: Bool = {
        var isSimulator = false
        #if arch(i386) || arch(x86_64)
            isSimulator = true
        #endif
        return isSimulator
    }()
}
