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

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let loginViewController = LoginView()
            let vc = UIHostingController(rootView: loginViewController)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }

}
