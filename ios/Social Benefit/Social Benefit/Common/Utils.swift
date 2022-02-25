//
//  Utils.swift
//  Social Benefit
//
//  Created by chu phuong dong on 26/11/2021.
//

import Foundation
import UIKit
import SwiftUI

class Utils {
    static func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    static func setLoginIsRoot() {
         if let sceneDelegate = UIApplication.shared.connectedScenes
                .first?.delegate as? SceneDelegate, let rootView = sceneDelegate.window?.rootViewController {
             if !(rootView is UIHostingController<LoginView>) {
                 sceneDelegate.window?.rootViewController = UIHostingController(rootView: LoginView())
             }
         }
    }
    
    static func setTabbarIsRoot() {
         if let sceneDelegate = UIApplication.shared.connectedScenes
                .first?.delegate as? SceneDelegate {
             sceneDelegate.window?.rootViewController = UIHostingController(rootView:  HomeScreenView(selectedTab: "house"))
         }
    }
    
    static let millisecondsFromGMT = 1000 * TimeZone.autoupdatingCurrent.secondsFromGMT()
    
    static func formatPointText(point: Int?) -> String {
        if let point = point {
            let nf = NumberFormatter()
            nf.numberStyle = .decimal
            let number = nf.string(from: NSNumber.init(value: point))
            return number ?? ""
        }
        return ""
    }
    
    static func pointValueText(point: Int?) -> String {
        if let point = point {
            if point < 2 {
                return "point".localized
            } else {
                return "points".localized
            }
        }
        return "point".localized
    }
}
