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

class UserService {
    
    func getAPI(keyword: String, fromIndex: Int, returnCallBack: @escaping ([UserData]) -> ()) {
        let service = BaseAPI()
        var data = [UserData]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId]
        
        let params: Parameters = ["keyword": keyword,
                                  "fromIndex": fromIndex]
        
        service.makeCall(endpoint: Config.API_RECOGNITION_FIND_EMPLOYEE, method: "POST", header: header, body: params, callback: { (result) in
            
            for i in 0..<result.count {
                let id = result[i]["id"].int ?? 0
                let avatar = result[i]["avatar"].string ?? ""
                let employeeCode = result[i]["employeeCode"].string ?? ""
                let nickname = result[i]["nickname"].string ?? ""
                let fullName = result[i]["fullName"].string ?? ""
                let positionName = result[i]["positionName"].string ?? ""
                let devisionName = result[i]["devisionName"].string ?? ""
                let departmentName = result[i]["departmentName"].string ?? ""
                
                let temp = UserData(id: id, avatar: avatar, employeeCode: employeeCode, nickname: nickname, fullName: fullName, positionName: positionName, devisionName: devisionName, departmentName: departmentName)
                
                data.append(temp)
            }
        
            returnCallBack(data)
        })
    }
}
