//
//  Constants.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import CocoaLumberjack

// MARK: Enumerators

enum AnimationDuration: TimeInterval {
    case slow      = 0.5
    case `default` = 0.3
    case fast      = 0.1
    case none      = 0.0
}

struct Constants {
    
    // MARK: XMPP Info
    static let xmppPort: UInt16 = 5222
    static let logLevel: DDLogLevel = .all
    static let xmppResource = "Phone"
    static let xmppServer   = "xmpp.test"
    
    
    // MARK: Numbers
    
    static let separatorHeight: CGFloat         = 1.0
    static let defaultTableRowHeight: CGFloat   = 44.0
    static let defaultLabelHeight: CGFloat      = 21.0
    static let defaultTextFieldHeight: CGFloat  = 30.0
    static let navigationBarHeight: CGFloat     = 44.0
    static let statusBarHeight: CGFloat         = 20.0
    static let totalNavigationHeight: CGFloat   = navigationBarHeight + statusBarHeight
    
    
    // MARK: App/Device info
    
    static let secret      = "eE39C1O6l4aCTGW4gTHAOwVGdMbT1d0Y"
    static let deviceOS    = "1"
    static let defaultLang = "en"
    static let locale      = "en_US"
    static let appVersion  = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    static let deviceLang  = Foundation.Locale.preferredLanguages.first?.components(separatedBy: "-").first
    static let deviceId    = UIDevice.current.identifierForVendor?.uuidString
}

struct Parameters {
    
    static let from        = "from"
    static let chat        = "chat"
    static let name        = "name"
    static let lang        = "lang"
    static let email       = "email"
    static let password    = "password"
    static let defaultLang = "en"
    static let id          = "id"
    static let notes       = "notes"
    static let body        = "body"
    static let command     = "command"
    static let description = "description"
    static let OS          = "os"
    static let version     = "version"
    static let status      = "status"
    static let IP          = "ip"
    static let language    = "language"
    static let session     = "session"
    static let title       = "title"
    static let content     = "content"
    static let delay       = "delay"
    static let firstName   = "firstName"
    static let lastName    = "lastName"
    static let token       = "token"
}

struct DateFormats {
    
    static let timeFormat                 = "HH:mm"
    static let dateFormatter              = "dd.MM.yyyy"
    static let serverDateFormatter        = "yyyy-MM-dd"
    static let dateTimeFormatter          = "dd.MM.yyyy HH:mm:ss"
    static let localizedDateFormat        = "dd/yyyy"
    static let yearDateFormat             = "yyyy"
    static let fullDateTimeFormat         = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
}

struct TimeZones {
    
    static let deviceTimeZone = TimeZone.current
    static let utcTimeZone    = TimeZone(identifier: "UTC")!
}

struct Locales {
    
    static let usLocale = Locale(identifier: "en_US")
}

struct UserDefaultsKeys {
    
}

struct Storyboards {
    
    static let main = "Main"
}

struct Colors {
    
    static let activeGreen    = "26CE21"
    static let deleteRed      = "E43A2D"
    static let separatorGray  = "DADADA"
    static let backgroundGray = "F9F9F9"
}

struct HTTPMethods {
    
    static let get  = "GET"
    static let post = "POST"
}
