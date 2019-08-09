//
//  LoginViewController.swift
//  LocalAuthenSample
//
//  Created by nguyen.duc.huyb on 8/9/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit
import LocalAuthentication

final class LoginViewController: UIViewController {
    @IBOutlet private weak var touchIDButton: UIButton!
    
    private var localAuth: LocalAuthentication!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        localAuth = LocalAuthentication()
        // #available(iOS 8.0, macOS 10.12.1, *)
        touchIDButton.isHidden = !localAuth.canEvaluatePolicy() // Check whether the device can implement biometric authentication
        
        switch localAuth.biometricType() {
        case .faceID:
            touchIDButton.setImage(#imageLiteral(resourceName: "faceid"),  for: .normal)
        default:
            touchIDButton.setImage(#imageLiteral(resourceName: "fingerprint"),  for: .normal)
        }
    }

    @IBAction func handleTouchIDButtonTapped(_ sender: Any) {
        localAuth.authenticateUser() { [weak self] message in
            guard let self = self else { return }
            
            if let message = message {
                // if the completion is not nil show an alert
                self.showAlert(title: "Error", message: message)
            } else {
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
                self.present(vc, animated: true)
            }
        }
    }
}
