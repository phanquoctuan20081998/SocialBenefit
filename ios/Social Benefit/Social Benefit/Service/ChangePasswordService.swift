//
//  ChangePasswordService.swift
//  Social Benefit
//
//  Created by Admin on 10/1/21.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class ChangePasswordService {
    
    func getAPI(userId: String, oldPass: String, newPass: String, returnCallBack: @escaping (Int) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token]
        
        let params: Parameters = ["userId": userId,
                      "oldPass": MD5(oldPass) ?? "",
                      "newPass": MD5(newPass) ?? ""]

        service.makeCall(endpoint: Config.API_EMPLOYEE_CHANGEPASSWORD, method: "POST", header: header, body: params, callback: { result in
            returnCallBack(result["code"].int ?? -2)
        })
    }
}
