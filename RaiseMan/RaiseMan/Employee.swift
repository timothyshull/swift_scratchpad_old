//
//  Employee.swift
//  RaiseMan
//
//  Created by Tim Shull on 9/21/16.
//  Copyright © 2016 Tim Shull. All rights reserved.
//

import Foundation

class Employee: NSObject {
    var name: String? = "New Employee"
    var raise: Float = 0.05
    
    func validateRaise(raiseNumberPointer: AutoreleasingUnsafeMutablePointer<NSNumber?>, error outError: NSErrorPointer) -> Bool {
        let raiseNumber = raiseNumberPointer.pointee
        if raiseNumber == nil {
            let domain = "UserInputValidationErrorDomain"
            let code = 0
            let userInfo = [NSLocalizedDescriptionKey: "An employee's raise must be a number"]
            outError?.pointee = NSError(domain: domain, code: code, userInfo: userInfo)
            return false
        } else {
            return true
        }
    }
}
