//
//  ResetPasswordService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/10/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class ResetPasswordService {
    
    func getAPI(companyCode: String, email: String, returnCallBack: @escaping (Int) -> ()) {
        let service = BaseAPI()
        
        let params = ["email": email,
                      "companyCode": companyCode]

        service.makeCall(endpoint: Config.API_EMPLOYEE_FORGOTPASS, method: "POST", header: ["":""], body: params as [String : Any], callback: { (result) in
            returnCallBack(result["code"].int ?? 1)
        })
    }
}
