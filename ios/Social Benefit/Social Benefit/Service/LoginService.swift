//
//  LoginService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/10/2021.
//

import Alamofire
import SwiftyJSON

class LoginService: APIServiceProtocol {
    
    let apiRequest = APIRequest()
    
    func getAPI(companyCode: String, userLogin: String, password: String, completion: @escaping (Result<LoginModel, AppError>) -> Void) {
        let passMd5 = MD5(password)
        
        let body = LoginRequestModel.init(companyCode: companyCode, userLogin: userLogin, password: passMd5)
        
        apiRequest.request(url: Config.API_LOGIN, method: .post, httpBody: body, type: LoginModel.self, customError: "wrong_login_data".localized) { response in
            completion(response)
        }
    }
}

