//
//  LogInView.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 13.12.21.
//

import UIKit

class LogInView: UIView {

    var titleLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Log In"
        nameLabel.textColor = Colors.textColor.getUIColor()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        nameLabel.numberOfLines = 2
        // nameLabel.textAlignment = .center
        return nameLabel
    }()

    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.placeholder = "E-mail"
        return textField
    }()

    var passTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.placeholder = "Password"
        return textField
    }()

    var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
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

        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(safeAreaLayoutGuide).offset(60)
            constraints.leading.equalToSuperview().offset(30)
            constraints.trailing.equalToSuperview().offset(-30)
        }

        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleLabel.snp.bottom).offset(40)
            constraints.leading.equalToSuperview().offset(30)
            constraints.trailing.equalToSuperview().offset(-30)
            constraints.height.equalTo(emailTextField.snp.width).multipliedBy(0.15)
        }

        self.addSubview(passTextField)
        passTextField.snp.makeConstraints { constraints in
            constraints.top.equalTo(emailTextField.snp.bottom).offset(20)
            constraints.leading.equalToSuperview().offset(30)
            constraints.trailing.equalToSuperview().offset(-30)
            constraints.height.equalTo(passTextField.snp.width).multipliedBy(0.15)
        }

        self.addSubview(logInButton)
        logInButton.snp.makeConstraints { constraints in
            constraints.top.equalTo(passTextField.snp.bottom).offset(40)
            constraints.centerX.equalToSuperview()
            constraints.width.equalToSuperview().multipliedBy(0.7)
            constraints.height.equalTo(logInButton.snp.width).multipliedBy(0.2)
        }
    }

    func setupSubviews() {
        logInButton.layer.cornerRadius = logInButton.frame.height / 2
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        passTextField.layer.cornerRadius = passTextField.frame.height / 2
    }
}
