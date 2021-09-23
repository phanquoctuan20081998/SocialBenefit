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
                      "employeeId": userInfor.employeeId]
        
        var id: Int?
        var title: String?
        var body: String?
        var logo: String?
        var typeMember: Int?
        var status: Int?
        var mobileStatus: Int?
        
        service.makeCall(endpoint: Config.API_BENEFIT_LIST, method: "POST", header: header as [String : String], body: ["":""]) { (result) in
            
            let resultArray = result
            let numOfList = resultArray.count
                
            for i in 0..<numOfList {
                let resultDic = resultArray[i]
                id = resultDic["id"].int ?? 0
                title = resultDic["title"].string ?? ""
                body = resultDic["body"].string ?? ""
                logo = resultDic["company"]["logo"].string ?? ""
                typeMember = resultDic["typeMember"].int ?? 0
                status = resultDic["status"].int ?? 0
                mobileStatus = resultDic["mobileStatus"].int ?? 0
                
                data.append(BenefitData(id: id!, title: title!, body: body!, logo: logo!, typeMember: typeMember!, status: status!, mobileStatus: mobileStatus!))
            }
            
            returnCallBack(data)
        }
    }
}







