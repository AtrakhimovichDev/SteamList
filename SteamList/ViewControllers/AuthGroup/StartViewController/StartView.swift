//
//  StartView.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 13.12.21.
//

import UIKit

class StartView: UIView {

    var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()

    var greetingLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Welcome to Steam App"
        nameLabel.textColor = Colors.textColor.getUIColor()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        return nameLabel
    }()

    var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = Colors.buttonColor.getUIColor()
        return button
    }()

    var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = Colors.buttonColor.getUIColor()
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        startSettings()
    }

    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        startSettings()
    }

    private func startSettings() {
        self.setGradientBackground(firstColor: Colors.firstBackgroundColor.getUIColor(),
                                   secondColor: Colors.secondBackgroundColor.getUIColor())
        self.addSubview(logoImage)
        logoImage.snp.makeConstraints { constraints in
            constraints.top.equalTo(safeAreaLayoutGuide).offset(60)
            constraints.centerX.equalToSuperview()
            constraints.width.equalToSuperview().multipliedBy(0.3)
            constraints.height.equalTo(logoImage.snp.width)
        }

        self.addSubview(greetingLabel)
        greetingLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(logoImage.snp.bottom).offset(40)
            constraints.leading.equalToSuperview().offset(20)
            constraints.trailing.equalToSuperview().offset(-20)
        }

        self.addSubview(logInButton)
        logInButton.snp.makeConstraints { constraints in
            constraints.top.equalTo(greetingLabel.snp.bottom).offset(40)
            constraints.centerX.equalToSuperview()
            constraints.width.equalToSuperview().multipliedBy(0.7)
            constraints.height.equalTo(logInButton.snp.width).multipliedBy(0.2)
        }

        self.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { constraints in
            constraints.top.equalTo(logInButton.snp.bottom).offset(20)
            constraints.centerX.equalToSuperview()
            constraints.width.equalToSuperview().multipliedBy(0.7)
            constraints.height.equalTo(signUpButton.snp.width).multipliedBy(0.2)
        }
    }

    func setupSubviews() {
        logInButton.layer.cornerRadius = logInButton.frame.height / 2
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
    }
}
