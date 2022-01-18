//
//  VUIAppService.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 18/01/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class VUIAppService {
    
    func getAPI(token: String, url: String, employeeCode: String, phoneNumber: String, returnCallBack: @escaping (VUIAppResponse) -> ()) {
        let service = BaseAPI(baseURL: url)
        
        let header = ["Authorization": "Bearer " + token,
                      "Content-Type": "application/json"]
        
        
        let params: Parameters = ["employeeCode": employeeCode,
                                  "phoneNumber": phoneNumber]
        
        service.makeCall(endpoint: "", method: "POST", header: header, body: params, callback: { (result) in
            
            print(result)
        })
    }
}
