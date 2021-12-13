//
//  LogInViewController.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 13.12.21.
//

import UIKit

class LogInViewController: UIViewController {

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
        // customView.setupSubviews()
    }
}
