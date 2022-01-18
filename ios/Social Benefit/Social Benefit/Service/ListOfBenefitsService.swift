//
//  GetData.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/08/2021.
//

import Foundation
import SwiftUI

class ListOfBenefitsService {
    
    func getAPI(returnCallBack: @escaping ([BenefitData]) -> ()) {
        let service = BaseAPI()
        var data = [BenefitData]()
        
        let header = ["token": userInfor.token,
                      "user_id": userInfor.userId,
                      "companyId": userInfor.companyId,
                      "employeeId": userInfor.employeeId,
                      "timezoneOffset":  "\(Utils.millisecondsFromGMT / -60000)"]
        
        var id: Int = 0
        var title: String = ""
        var body: String = ""
        var logo: String = ""
        var typeMember: Int = 0
        var status: Int = 0
        var mobileStatus: Int = 0
        var actionTime: String = ""
        
        service.makeCall(endpoint: Config.API_BENEFIT_LIST, method: "POST", header: header as [String : String], body: ["":""]) { (result) in
            
            let resultArray = result
            let numOfList = resultArray.count

            for i in 0..<numOfList {
                let resultDic = resultArray[i]
                
                id = resultDic["id"].int ?? 0
                title = resultDic["title"].string ?? ""
                body = resultDic["body"].string ?? ""
                logo = resultDic["logo"].string ?? userInfor.companyLogo
                typeMember = resultDic["typeMember"].int ?? 0
                status = resultDic["status"].int ?? 0
                mobileStatus = resultDic["mobileStatus"].int ?? 0
                actionTime = resultDic["actionTime"].string ?? ""
                
                if (logo.isEmpty) { logo = userInfor.companyLogo }
                
                data.append(BenefitData(id: id, title: title, body: body, logo: logo, typeMember: typeMember, status: status, mobileStatus: mobileStatus, actionTime: actionTime))
            }
            
            returnCallBack(data)
        }
    }
}







