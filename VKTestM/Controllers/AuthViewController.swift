//
//  AuthViewController.swift
//  VKTestM
//
//  Created by Dmitry on 14.08.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
    }
    
    @IBAction func signInVK(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}

