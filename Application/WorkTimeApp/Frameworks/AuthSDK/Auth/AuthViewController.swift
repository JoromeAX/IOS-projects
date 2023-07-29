//
//  AuthViewController.swift
//  Pods
//
//  Created by Roman Khancha on 28.07.2023.
//

import UIKit
import SnapKit
import UIComponents

fileprivate extension Constants {
    static let horizontalOffset: CGFloat = 45
    static let deviderlOffset: CGFloat = 5
    static let interItemOffset: CGFloat = 58
    static let fieldHeight: CGFloat = 28
}

public final class AuthViewController: BaseViewController {
    private let contentView = UIView()
    private let loginTabButton = UIButton()
    private let buttonDeviderView = UILabel()
    private let singUpTabButton = UIButton()
    private let usernameTextField = WTAuthTextField()
    private let passwordTextField = WTAuthTextField()
    private let loginButton = UIButton()
    
    public override func setup() {
        super.setup()
        
        view.backgroundColor = .white
        
        setupContentView()
        setupLoginTabButton()
        setupButtonDeviderView()
        setupSingUpTabButton()
        setupUsernameTextField()
        setupPasswordTextField()
        setupLoginButton()
    }
}

private extension AuthViewController {
    func setupContentView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.centerY.horizontalEdges.equalToSuperview()
        }
    }
    
    func setupLoginTabButton() {
        contentView.addSubview(loginTabButton)
        
        loginTabButton.setTitle("Login", for: .normal)
        loginTabButton.setTitleColor(.black, for: .normal)
        
        loginTabButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(Constants.horizontalOffset)
        }
    }
    
    func setupButtonDeviderView() {
        contentView.addSubview(buttonDeviderView)
        
        buttonDeviderView.text = "/"
        
        buttonDeviderView.snp.makeConstraints {
            $0.centerY.equalTo(loginTabButton)
            $0.leading.equalTo(loginTabButton.snp.trailing).offset(Constants.deviderlOffset)
        }
    }
    
    func setupSingUpTabButton() {
        contentView.addSubview(singUpTabButton)
        
        singUpTabButton.setTitle("Sing Up", for: .normal)
        singUpTabButton.setTitleColor(.black, for: .normal)
        
        singUpTabButton.snp.makeConstraints {
            $0.bottom.equalTo(loginTabButton)
            $0.leading.equalTo(buttonDeviderView.snp.trailing).offset(Constants.deviderlOffset)
        }
    }
    
    func setupUsernameTextField() {
        contentView.addSubview(usernameTextField)
        
        usernameTextField.placeholder = "Username"
        
        usernameTextField.snp.makeConstraints {
            $0.bottom.equalTo(loginTabButton.snp.bottom).offset(Constants.interItemOffset)
            $0.leading.equalToSuperview().inset(Constants.horizontalOffset)
            $0.height.equalTo(Constants.fieldHeight)
        }
    }
    
    func setupPasswordTextField() {
        contentView.addSubview(passwordTextField)
        
        passwordTextField.placeholder = "Password"
        
        passwordTextField.snp.makeConstraints {
            $0.bottom.equalTo(usernameTextField.snp.bottom).offset(Constants.interItemOffset)
            $0.leading.equalToSuperview().inset(Constants.horizontalOffset)
            $0.height.equalTo(Constants.fieldHeight)
        }
    }
    
    func setupLoginButton() {
        contentView.addSubview(loginButton)
        
        loginButton.setTitle("Password", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(passwordTextField.snp.bottom).offset(Constants.interItemOffset)
            $0.trailing.equalToSuperview().inset(Constants.horizontalOffset)
            $0.bottom.equalToSuperview()
        }
    }
}
