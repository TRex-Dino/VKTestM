//
//  AuthViewController.swift
//  VKTestM
//
//  Created by Dmitry on 14.08.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var enterButton: UIButton!
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterButton.layer.cornerRadius = 10
        enterButton.setTitle(LocalizeString.loginTitle.setString, for: .normal)
        
        authService = SceneDelegate.shared().authService
    }
    
    @IBAction func signInVK(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}

