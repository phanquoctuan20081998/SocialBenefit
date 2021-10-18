//
//  LoginService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/10/2021.
//

import Alamofire
import SwiftyJSON

class LoginService {
    
    func getAPI(companyCode: String, userLogin: String, password: String, returnCallBack: @escaping (JSON) -> ()) {
        let service = BaseAPI()
        
        let passMd5 = MD5(password)
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        let deviceToken = "abcd"
        let deviceType = "1" //For iPhone
        
        let params = ["companyCode": companyCode,
                      "userLogin": userLogin,
                      "password": passMd5,
                      "deviceId": deviceId,
                      "deviceToken": deviceToken,
                      "deviceType": deviceType]

        service.makeCall(endpoint: Config.API_LOGIN, method: "POST", header: ["":""], body: params as [String : Any], callback: { (result) in
            returnCallBack(result)
        })
    }
}

