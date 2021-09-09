//
//  ApplyBenefitService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

    
class ApplyBenefitService {
    
    func getAPI(benefitId: Int) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId,
                      "benefitId": String(benefitId)]
        
        let params: Parameters = ["":""]
        
        service.makeCall(endpoint: Constant.API_BENEFIT_APPLY, method: "POST", header: header as [String : String], body: params, callback: { result in
            print("Apply id = \(result["id"])")
        })
    }
}
