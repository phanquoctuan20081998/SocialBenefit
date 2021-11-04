//
//  UserInformationUpdateService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 22/10/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class UserInformationService {
    
    func getAPI(id: String, nickName: String, address: String, citizenId: String, email: String, phone: String, birthday: String, locationId: String, returnCallBack: @escaping (Bool) -> ()) {
        
        // Trim white space...
        let nickName = nickName.trimmingCharacters(in: .whitespacesAndNewlines)
        let address = address.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let service = BaseAPI_Alamofire()
        
        let header: HTTPHeaders = ["token": userInfor.token,
                                   "companyId": userInfor.companyId]
        
        let params: Parameters = ["id": id,
                                  "nickName": nickName,
                                  "address": address,
                                  "citizenId": citizenId,
                                  "email": email,
                                  "phone": phone,
                                  "birthday": birthday,
                                  "locationId": locationId]
        
        print(params)
        
        service.makeCall(endpoint: Config.API_EMPLOYEE_INFO_UPDATE, method: "POST", header: header, body: params, callback: { (result) in
            if result.isEmpty {
                returnCallBack(false)
            } else {
                returnCallBack(true)
            }
        })
    }
}
