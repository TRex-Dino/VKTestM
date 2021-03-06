//
//  SceneDelegate.swift
//  VKTestM
//
//  Created by Dmitry on 14.08.2021.
//

import UIKit
import VK_ios_sdk

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AuthServiceDelegate {
    
    var window: UIWindow?
    var authService: AuthService!
    
    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        let sceneDelegate: SceneDelegate = ((scene?.delegate as? SceneDelegate)!)
        return sceneDelegate
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        authService = AuthService()
        authService.delegate = self
        
        let authVC = UIStoryboard(name: "AuthViewController", bundle: nil).instantiateInitialViewController() as? AuthViewController
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }
    
    //MARK: - AuthServiceDelegate
    func authServiceShouldShow(viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        guard let albumVC = UIStoryboard(name: "AlbumViewController", bundle: nil).instantiateInitialViewController() as? AlbumViewController else { return }
        
        let navVC = UINavigationController(rootViewController: albumVC)
        window?.rootViewController = navVC
        
    }
    
    func authServiceLogOut() {
        let authVC = UIStoryboard(name: "AuthViewController", bundle: nil).instantiateInitialViewController() as! AuthViewController
        window?.rootViewController = authVC
    }
    
    func authServiceSignInDidFail() {
        let ac = UIAlertController(title: LocalizeString.authAlertTitle.setString, message: LocalizeString.authAlertCommit.setString, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        ac.addAction(ok)
        
        window?.rootViewController?.present(ac, animated: true)
    }
}
