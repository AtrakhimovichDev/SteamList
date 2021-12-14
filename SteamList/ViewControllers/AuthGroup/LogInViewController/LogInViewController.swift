//
//  LogInViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 13.12.21.
//

import UIKit

class LogInViewController: UIViewController {

    private let authManager: FBAuth = FirebaseAuthManager()
    private let customView = LogInView()

    override func loadView() {
        view = customView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView.setupSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
    }

    @objc
    private func logInButtonPressed() {
        authManager.signIn(email: customView.emailTextField.text!,
                           password: customView.passTextField.text!) { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                self.showErrorAlert(message: error)
            } else {
                self.openMainVC()
            }
        }
    }

    private func openMainVC() {
        let navVC = ViewControllersFactory.shared.createMainNavControllerController()
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }

    private func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
}
