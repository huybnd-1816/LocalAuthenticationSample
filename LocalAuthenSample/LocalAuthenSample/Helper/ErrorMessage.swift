//
//  ErrorMessage.swift
//  LocalAuthenSample
//
//  Created by nguyen.duc.huyb on 8/9/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

enum ErrorMessage: String {
    case authenticationFailed = "There was a problem verifying your identity."
    case userCancel = "You pressed cancel."
    case userFallback = "You pressed password."
    case biometryNotAvailable = "Face ID/Touch ID is not available."
    case biometryNotEnrolled = "Face ID/Touch ID is not set up."
    case biometryLockout = "There were too many failed attempts."
    case passcodeNotSet = "There is no passcode enabled as required for Touch ID"
    case notConfigured = "Face ID/Touch ID may not be configured"
}

enum BaseError {
    case authenticationFailed
    case userCancel
    case userFallback
    case biometryNotAvailable
    case biometryNotEnrolled
    case biometryLockout
    case passcodeNotSet
    case notConfigured
    
    var message: String {
        switch self {
        case .authenticationFailed:
            return ErrorMessage.authenticationFailed.rawValue
        case .userCancel:
            return ErrorMessage.userCancel.rawValue
        case .userFallback:
            return ErrorMessage.userFallback.rawValue
        case .biometryNotAvailable:
            return ErrorMessage.biometryNotAvailable.rawValue
        case .biometryLockout:
            return ErrorMessage.biometryLockout.rawValue
        case .biometryNotEnrolled:
            return ErrorMessage.biometryNotEnrolled.rawValue
        case .passcodeNotSet:
            return ErrorMessage.passcodeNotSet.rawValue
        default:
            return ErrorMessage.notConfigured.rawValue
        }
    }
}
