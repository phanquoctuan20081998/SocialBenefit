//
//  UserService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/12/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class MerchantSpecialSettingsService {
    
    func getAPI(code: String, returnCallBack: @escaping (JSON) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "code": code]
        
        let params: Parameters = ["": ""]
        
        service.makeCall(endpoint: Config.API_MERCHANT_SPECIAL_SETTINGS_GET, method: "POST", header: header, body: params, callback: { (result) in
            
            let value = result["value"].string ?? ""
            let valueJson = JSON.init(parseJSON: value)
            
            returnCallBack(valueJson)
        })
    }
}
