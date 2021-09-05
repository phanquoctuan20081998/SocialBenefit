//
//  GetData.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/08/2021.
//

import Foundation
import SwiftUI

class ListOfBenefitsService {
    
    func getAPI(returnCallBack: @escaping ([ListOfBenefitData]) -> ()) {
        var data = [ListOfBenefitData]()
        let service = BaseAPI()
        
        var order: Int = 0
        var tempBenefitData = ListOfBenefitData(id: 0, order: "", benefit: "", applied: STATUS().REJECTED)
        
        let header = ["token": userInfor.token,
                      "user_id": userInfor.userId,
                      "companyId": userInfor.companyId,
                      "employeeId": userInfor.employeeId]
        
        var title: String?
        var status: Int?
        
        service.makeCall(endpoint: Constant.API_BENEFIT_LIST, method: "POST", header: header as [String : String], body: ["":""], callback: { (result) in

            let resultArray = result
            let numOfList = resultArray.count
                
            for i in 0..<numOfList {
                let resultDic = resultArray[i]
                title = resultDic["title"].string ?? ""
                status = resultDic["mobileStatus"].int ?? 0
                
                // Add id, oder
                tempBenefitData.id = order
                tempBenefitData.order = String(order)
                
                
                // Add benefit
                tempBenefitData.benefit = title ?? ""
                
                // Add applied
                switch status {
                case 0: do {tempBenefitData.applied = STATUS().ON_GOING}
                case 1: do {tempBenefitData.applied = STATUS().UP_COMMING}
                case 2: do {tempBenefitData.applied = STATUS().RECEIVED}
                case 3: do {tempBenefitData.applied = STATUS().NOT_REGISTER}
                case 4: do {tempBenefitData.applied = STATUS().REGISTER}
                case 5: do {tempBenefitData.applied = STATUS().APPROVED}
                default: do {tempBenefitData.applied = STATUS().REJECTED}
                }
                
                data.append(tempBenefitData)
                order += 1
            }
            returnCallBack(data)
        })
    }
}







