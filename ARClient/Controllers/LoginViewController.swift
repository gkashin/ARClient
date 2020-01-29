//
//  LoginViewController.swift
//  ARClient
//
//  Created by Георгий Кашин on 24.01.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - IB Actions
    @IBAction func signInButtonPressed() {
        guard let username = loginTextField.text,
            let password = passwordTextField.text else { return }
        NetworkManager.shared.checkLogin(for: username, with: password) { user in
            guard let user = user else {
                print(#line, #function, "User is nil")
                return
            }
            
            print("\(user.username) + \(user.isAdmin)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

