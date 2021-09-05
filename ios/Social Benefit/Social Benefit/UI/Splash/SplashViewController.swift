//
//  SplashViewController.swift
//  Social Benefit
//
//  Created by Admin on 7/8/21.
//

import UIKit
import SwiftUI

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            let loginViewController = LoginViewController()
//            let loginViewController = ResetSuccessViewController()
//            let loginViewController = ResetPasswordViewController()
            
//            if #available(iOS 13.0.0, *) {
//                let loginViewController = ListOfBenefitsView()
//                let vc = UIHostingController(rootView: loginViewController)
////                self.navigationController?.pushViewController(vc, animated: true)
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)
//            } else {
                // Fallback on earlier versions
//            }
            
//            let loginViewController = HomeViewController()
            
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
        }
    }

}
