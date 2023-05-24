//
//  ViewController.swift
//  DummyIosSdk
//
//  Created by alexza on 05/10/2023.
//  Copyright (c) 2023 alexza. All rights reserved.
//

import UIKit
import SwiftUI
//import Trackerku

class ViewController: UIViewController, URLSessionDelegate {
    
    private var usernameTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create and configure the username text field
        usernameTextField = UITextField(frame: CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 40))
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        view.addSubview(usernameTextField)

        // Create and configure the password text field
        passwordTextField = UITextField(frame: CGRect(x: 20, y: 160, width: view.bounds.width - 40, height: 40))
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)

        // Create and configure the login button
        loginButton = UIButton(type: .system)
        loginButton.frame = CGRect(x: 20, y: 220, width: view.bounds.width - 40, height: 40)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func loginButtonTapped() {
        
    }
}

