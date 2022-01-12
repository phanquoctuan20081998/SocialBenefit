//
//  BenefitDetailService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 07/01/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class BenefitDetailService {
    
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func getAPI(returnCallBack: @escaping (BenefitData) -> ()) {
        let service = BaseAPI_Alamofire()
    
        let endPoint = Config.API_BENEFIT_GET + "/\(self.id)"
        let header: HTTPHeaders = ["token": userInfor.token,
                                   "user_id" : userInfor.employeeId,
                                   "companyId": userInfor.companyId]
        
        let params: Parameters = ["":""]
        
        service.makeCall(endpoint: endPoint, method: "GET", header: header, body: params, callback: { result in

            let id = result["id"].int ?? -1
            let title = result["title"].string ?? ""
            let body = result["body"].string ?? ""
            let status = result["status"].int ?? 0
            let logo = result["logo"].string ?? ""
            let typeMember = result["typeMember"].int ?? 0
            let mobileStatus = result["mobileStatus"].int ?? 0
            
               
            let data = BenefitData(id: id, title: title, body: body, logo: logo, typeMember: typeMember, status: status, mobileStatus: mobileStatus)
                   
            returnCallBack(data)
        })
    }
}
