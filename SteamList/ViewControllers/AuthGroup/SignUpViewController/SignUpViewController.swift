//
//  SignUpViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 13.12.21.
//

import UIKit

class SignUpViewController: UIViewController {

    private let authManager: FBAuth = FirebaseAuthManager()
    private let customView = SignUpView()

    override func loadView() {
        view = customView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView.setupSubviews()
        customView.signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc
    private func signUpButtonPressed() {
        authManager.createUser(email: customView.emailTextField.text!,
                               password: customView.passTextField.text!) { [weak self] (error) in
            guard let self = self else { return }
            var message: String = ""
            if let error = error {
                message = error
            } else {
                message = "There was an error."
            }
            self.showErrorAlert(message: message)
            
        }
    }

    private func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
}
