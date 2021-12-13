//
//  StartViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 13.12.21.
//

import UIKit

class StartViewController: UIViewController {
    
    private let customView = StartView()

    override func loadView() {
        view = customView
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        customView.setupSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        customView.signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    }

    @objc
    private func logInButtonPressed() {
        let logInVC = LogInViewController()
        self.present(logInVC, animated: true)
    }

    @objc
    private func signUpButtonPressed() {
        let signUpVC = SignUpViewController()
        self.present(signUpVC, animated: true)
    }
}
