//
//  ResetSuccessViewControl.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/08/2021.
//

import UIKit

class ResetSuccessViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var noti1: UILabel!
    @IBOutlet weak var noti2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.setTitle("login".localized, for: .normal)
        noti1.text = "success_notification1"
        noti2.text = "success_notification2"
        loginButton.circleCorner()
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        let loginViewController = LoginViewController()
        self.moveTo(loginViewController, animated: true)
    }
}
