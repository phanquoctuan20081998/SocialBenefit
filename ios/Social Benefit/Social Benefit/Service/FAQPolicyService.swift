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

class FAQPolicyService {
    
    func getAPI(docType: Int, lang_code: String, returnCallBack: @escaping (JSON) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "timezoneOffset":  "\(Utils.millisecondsFromGMT / -60000)"]
        
        let params: Parameters = ["typePage": docType,
                                  "typeTab": Constants.SystemType.Mobile,
                                  "lang_code": lang_code]
        
        service.makeCall(endpoint: Config.API_FAQ_POLICY_GET, method: "POST", header: header, body: params, callback: { (result) in
//            print(result)
            returnCallBack(result)
            
        })
    }
}

