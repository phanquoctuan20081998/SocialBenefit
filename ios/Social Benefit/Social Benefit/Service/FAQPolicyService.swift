//
//  FAQPolicyService.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 27/01/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class FAQPolicyService: APIServiceProtocol {
    
    let apiRequest = APIRequest()
    
    func request(docType: Int, completion: @escaping (Result<FAQPolicyModel, AppError>) -> Void) {
        
        let header: HTTPHeaders = ["token": userInfor.token,
                                   "timezoneOffset":  "\(Utils.millisecondsFromGMT / -60000)"]
        
        let body = FAQPolicyRequestModel.init(docType: docType)
        
        apiRequest.request(url: Config.API_FAQ_POLICY_GET, method: .post, headers: header, httpBody: body, type: FAQPolicyModel.self, debugPrint: false) { response in
            completion(response)
        }
    }
}

