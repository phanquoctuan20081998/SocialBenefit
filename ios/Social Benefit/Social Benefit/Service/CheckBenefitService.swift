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
   
    func getAPI(benefitId: Int, returnCallBack: @escaping (Int) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId,
                      "benefitId": String(benefitId)]
        
        let params: Parameters = ["":""]
        
        service.makeCall(endpoint: Config.API_BENEFIT_CHECK, method: "POST", header: header as [String : String], body: params, callback: { result in
            
            let status =  result["status"].int ?? -1
            
            returnCallBack(status)
        })
    }
}
