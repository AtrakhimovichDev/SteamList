//
//  SignUpViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 13.12.21.
//

import UIKit

class SignUpViewController: UIViewController {

    private let customView = SignUpView()

    override func loadView() {
        view = customView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView.setupSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
