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
        NetworkManager.shared.checkLogin(for: username, with: password) { (status, isAdmin) in
            if status == "ok" {
                if isAdmin != nil {
                    User.isAdmin = isAdmin!
                    print(User.isAdmin)
                }
                DispatchQueue.main.async {
//                    self.performSegue(withIdentifier: "SignInSegue", sender: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

