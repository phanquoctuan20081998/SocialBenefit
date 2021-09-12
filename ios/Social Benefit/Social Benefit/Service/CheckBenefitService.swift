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
    @Published var status = -1
    
    init(benefitId: Int) {
        self.getAPI(benefitId: benefitId)
    }
    
    func getAPI(benefitId: Int) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId,
                      "benefitId": String(benefitId)]
        
        let params: Parameters = ["":""]
        
        service.makeCall(endpoint: Constant.API_BENEFIT_CHECK, method: "POST", header: header as [String : String], body: params, callback: { result in
            
            DispatchQueue.main.async { [weak self] in
                self?.status = result["status"].int!
            }
        })
    }
}
