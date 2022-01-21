//
//  AppDelegate.swift
//  Social Benefit
//
//  Created by Admin on 7/8/21.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import SwiftUI

public var device_token = ""

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

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
            let vc = UIHostingController(rootView: SplashView())
//            let vc = SplashViewController()
            self.window!.rootViewController = vc
            self.window!.makeKeyAndVisible()
            self.window!.backgroundColor = .red
        }
        
        
        FirebaseApp.configure()
        
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // [END register_for_notifications]
        return true
        
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        self.window = self.window ?? UIWindow()
        
//        let vc = SplashViewController()
        let vc = UIHostingController(rootView: SplashView())
        
        // Set this scene's window's background color.
        self.window!.backgroundColor = UIColor.red
        
        // Create a ViewController object and set it as the scene's window's root view controller.
        self.window!.rootViewController = vc
        
        // Make this scene's window be visible.
        self.window!.makeKeyAndVisible()
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            
            device_token = token
            
            print("Token \(token)")
        }
    }

}

