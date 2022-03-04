//
//  CheckBenefitService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

    
class CheckBenefitService {
   
    func getAPI(benefitId: Int, returnCallBack: @escaping (String, BenefitData) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId,
                      "benefitId": String(benefitId)]
        
        let params: Parameters = ["":""]
        
        service.makeCall(endpoint: Config.API_BENEFIT_CHECK, method: "POST", header: header as [String : String], body: params, callback: { result in
            
            let error = result["errors"].string ?? "" // Update BD 1.10
            
            let id = result["benefit"]["id"].int ?? -1
            let title = result["benefit"]["title"].string ?? ""
            let status =  result["status"].int ?? -1
            let body = result["benefit"]["body"].string ?? ""
            var logo = result["benefit"]["logo"].string ?? userInfor.companyLogo
            let typeMember = result["benefit"]["typeMember"].int ?? -1
            let mobileStatus = result["benefit"]["mobileStatus"].int ?? -1
            let actionTime = result["benefit"]["actionTime"].string ?? ""
            if logo.isEmpty {
                logo = userInfor.companyLogo
            }
            let data = BenefitData(id: id, title: title, body: body, logo: logo, typeMember: typeMember, status: status, mobileStatus: mobileStatus, actionTime: actionTime)
            
            returnCallBack(error, data)
        })
    }
}
