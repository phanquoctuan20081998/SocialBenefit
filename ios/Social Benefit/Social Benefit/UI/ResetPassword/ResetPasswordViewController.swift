//
//  ResetPasswordViewControl.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/08/2021.
//

import UIKit
import SwiftyJSON

class ResetPasswordViewController: UIViewController {
    var service: BaseAPI = BaseAPI()
    
    @IBOutlet weak var company_code_txt: UITextField!
    @IBOutlet weak var email_txt: UITextField!
    @IBOutlet weak var reset_password_button: UIButton!
    @IBOutlet weak var back_to_login_button: UIButton!
    @IBOutlet weak var forgot_password_label: UILabel!
    @IBOutlet weak var infor_label: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let textCompanyCode = "company_code".localized
        let textEmail = "email_reset".localized
        forgot_password_label.text = "forgot_password".localized
        infor_label.text = "infor".localized
        
        reset_password_button.circleCorner()
        styleTextField(textField: company_code_txt, text: textCompanyCode)
        styleTextField(textField: email_txt, text: textEmail)
        reset_password_button.setTitle("reset_password".localized, for: .normal)
        back_to_login_button.setTitle("back_login".localized, for: .normal)
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        let resetEmail = email_txt.text ?? ""
        
        if (resetEmail.isEmpty) {
          return
        }
        
        let jsonBody = ["email": resetEmail]
        
        service.makeCall(endpoint: Constant.API_EMPLOYEE_FORGOTPASS, method: "POST", header: ["":""], body: jsonBody as [String : Any], callback: { (result) in
            
            if ((result["success"].bool)!) {
                // Move to Successfull Notification Screen
                DispatchQueue.main.async {
                    let resetSuccessfullViewController = ResetSuccessViewController()
                    self.moveTo(resetSuccessfullViewController, animated: true)
                }
            }
            
            else {
                // Print mail was wrong
                
                
            }
        })
    }
    
    @IBAction func backToLoginClicked(_ sender: Any) {
        let loginViewController = LoginViewController()
        self.moveTo(loginViewController, animated: true)
    }
    
    func styleTextField (textField: UITextField, text: String) {
        textField.setBorder(width: 1, color: .lightGray)
        textField.circleCorner()
        textField.setPlaceHolder(text: text)
    }
}
