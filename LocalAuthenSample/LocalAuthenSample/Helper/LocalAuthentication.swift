//
//  LocalAuthentication.swift
//  LocalAuthenSample
//
//  Created by nguyen.duc.huyb on 8/9/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import LocalAuthentication

enum BiometricType {
    case none
    case touchID
    case faceID
}

final class LocalAuthentication {
    
    private let context = LAContext()

    private var loginReason = "Logging in with Touch ID"
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func biometricType() -> BiometricType {
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch context.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        }
    }
    
    func authenticateUser(completion: @escaping (String?) -> Void) { // 1
        // Check whether the device is capable of biometric authentication.
        guard canEvaluatePolicy() else {
            completion("Touch ID not available")
            return
        }
        
        // Begin the policy evaluation
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: loginReason) { (success, evaluateError) in
                                // Handling the success case
                                if success {
                                    DispatchQueue.main.async {
                                        // User authenticated successfully, take appropriate action
                                        completion(nil)
                                    }
                                } else {
                                    // LAError cases
                                    let message = self.handleError(evaluateError)
                                    completion(message)
                                }
        }
    }

    private func handleError(_ err: Error?) -> String {
        let message: String
        
        switch err {
        case LAError.authenticationFailed?:
            message = BaseError.authenticationFailed.message
        case LAError.userCancel?:
            message = BaseError.userCancel.message
        case LAError.userFallback?:
            message = BaseError.userFallback.message
        case LAError.biometryNotAvailable?:
            message = BaseError.biometryNotAvailable.message
        case LAError.biometryNotEnrolled?:
            message = BaseError.biometryNotEnrolled.message
        case LAError.biometryLockout?:
            message = BaseError.biometryLockout.message
        case LAError.passcodeNotSet?:
            message = BaseError.passcodeNotSet.message
        default:
            message = BaseError.notConfigured.message
        }
        return message
    }
}
