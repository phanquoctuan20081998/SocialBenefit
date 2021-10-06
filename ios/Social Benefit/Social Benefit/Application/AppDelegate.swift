//
//  AppDelegate.swift
//  Social Benefit
//
//  Created by Admin on 7/8/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
                        launchOptions: [UIApplication.LaunchOptionsKey : Any]?)
    -> Bool {
        if #available(iOS 13, *) {
            // do only pure app launch stuff, not interface stuff
        } else {
            self.window = UIWindow()
            let vc = SplashViewController()
            self.window!.rootViewController = vc
            self.window!.makeKeyAndVisible()
            self.window!.backgroundColor = .red
        }
        FirebaseApp.configure()
        return true
       }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        self.window = self.window ?? UIWindow()
        
        // Set this scene's window's background color.
        self.window!.backgroundColor = UIColor.red
        
        // Create a ViewController object and set it as the scene's window's root view controller.
        self.window!.rootViewController = SplashViewController()
        
        // Make this scene's window be visible.
        self.window!.makeKeyAndVisible()
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }


}

