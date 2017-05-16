//
//  ResponseStatus.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 4/21/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import Foundation

struct Response {
    
    enum Status: Int {
        case unknown = -1
        case success
        case missingResponseData
        case sessionExpired
        case timeout
    }
    
    private static let kErrorDomain = "com.vc.XMPP-API-Demo-Communication"
    
        
    // MARK: Public Methods
    
    static func timeoutErrorForCommand(_ command: Int) -> NSError {
        return NSError(domain: kErrorDomain, code: command, userInfo: [
            Parameters.command        : command,
            Parameters.status         : Status.timeout.rawValue,
            NSLocalizedDescriptionKey : NSLocalizedString("An error occured. Please accept our appologies and try again later", comment: "Error")
            ]
        )
    }
    
    static func errorFromResponse(_ response: NSDictionary) -> NSError {
        guard let command = response[Parameters.command] as? Int,
              let status  = response[Parameters.status]  as? Int else {
                return self.missingDataError
        }
        
        let error = self.errorsForCommand(command, response: response)[status]
        
        return NSError(domain: kErrorDomain, code: status, userInfo: [
            Parameters.command        : command,
            Parameters.status         : status,
            NSLocalizedDescriptionKey : error ?? NSLocalizedString("An error occured. Please accept our appologies and try again later", comment: "Error")
            ])
    }
    
    
    // MARK: Private Methods
    
    private static func errorsForCommand(_ command: Int, response: NSDictionary) -> [Int : String] {
        guard let cmd = Command(rawValue: command) else {
            return self.defaultErrors
        }
        
        switch cmd {
        case .login:
            return self.loginErrors
            
        case .addNote:
            return self.addNoteErrors
            
        default:
            return self.defaultErrors
        }
    }
    
    
    // MARK: Helpers
    
    static var missingDataError: NSError {
        return NSError(domain: kErrorDomain,
                       code: Status.missingResponseData.rawValue,
                       userInfo: nil)
    }
    
    private static var loginErrors: [Int : String] {
        // Maybe set custom errors based on status
        return self.defaultErrors
    }
    
    private static var addNoteErrors: [Int : String] {
        // Maybe set custom errors based on status
        return self.defaultErrors
    }
    
    private static var defaultErrors: [Int : String] {
        return [
            Status.success.rawValue             : NSLocalizedString("Operation completed successfully",                                   comment: "Success"),
            Status.missingResponseData.rawValue : NSLocalizedString("An error occured. Please accept our appologies and try again later", comment: "Error"),
        ]
    }
}
