//
//  LoginViewController.swift
//  Social Benefit
//
//  Created by Admin on 7/8/21.
//

import UIKit
import SwiftUI
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {

    var service = BaseAPI()
    @IBOutlet weak var company_code_txt: UITextField!
    @IBOutlet weak var user_login_txt: UITextField!
    @IBOutlet weak var password_txt: UITextField!
    @IBOutlet weak var remember_me_label: UILabel!
    @IBOutlet weak var warning1_label: UILabel!
    @IBOutlet weak var warning2_label: UILabel!
    @IBOutlet weak var forgot_password_button: UIButton!
    @IBOutlet weak var login_button: UIButton!
    
    func multipleLangue() {
        company_code_txt.placeholder = "company".localized
        user_login_txt.placeholder = "email".localized
        password_txt.placeholder = "password".localized
        remember_me_label.text = "remember_me".localized
        warning1_label.text = "warning1".localized
        warning2_label.text = "warning2".localized
        forgot_password_button.setTitle("forgot_password".localized, for: .normal)
        login_button.setTitle("login".localized, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        multipleLangue()
        login_button.setCorner(radius: 10)
        login_button.backgroundColor = UIColor.init(red: 200/255, green: 217/255, blue: 248/255, alpha: 200/255)
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        let companyCode = company_code_txt.text ?? ""
        let userLogin = user_login_txt.text ?? ""
        let password = password_txt.text ?? ""
        
        if(companyCode.isEmpty || userLogin.isEmpty || password.isEmpty){
            return
        }
        
        let passMd5 = MD5(password)
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        let deviceToken = "tt" //Need to research
        let deviceType = "1" //For iPhone
        let jsonBody = ["companyCode": companyCode,
                        "userLogin": userLogin,
                        "password": passMd5,
                        "deviceId": deviceId,
                        "deviceToken": deviceToken,
                        "deviceType": deviceType]
        
        service.makeCall(endpoint: Config.API_LOGIN, method: "POST", header: ["":""], body: jsonBody as [String : Any], callback: { (result) in
            
            let token = result["token"]
            let employeeDto = result["employeeDto"]
            let citizen = employeeDto["citizen"]
            updateUserInfor(userId: userLogin, token: token.string!, employeeDto: employeeDto, citizen: citizen)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if #available(iOS 13.0.0, *) {
//                let loginViewController = HomeScreenView(selectedTab: "house")
                let loginViewController = Test()
                let vc = UIHostingController(rootView: loginViewController)
                //                self.navigationController?.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBAction func forgotPasswordButtonClicked(_ sender: Any) {
        moveTo(ResetPasswordViewController(), animated: true)
    }
    
    @IBAction func enButtonClicked(_ sender: Any) {
        Bundle.setLanguage(lang: "en")
        moveTo(LoginViewController(), animated: false)
    }
    
    @IBAction func vnButtonClicked(_ sender: Any) {
        Bundle.setLanguage(lang: "vn")
        moveTo(LoginViewController(), animated: false)
    }
}


