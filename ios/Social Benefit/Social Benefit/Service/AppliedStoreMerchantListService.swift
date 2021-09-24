//
//  AppliedStoreMerchantListService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class AppliedStoreMerchantListService {
    
    func getAPI(voucherId: Int, fromIndex: Int, returnCallBack: @escaping ([AppliedStoreMerchantListData]) -> ()) {
        let service = BaseAPI()
        var data = [AppliedStoreMerchantListData]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters = ["voucherId": voucherId,
                                  "fromIndex": fromIndex]
        
        var id: Int?
        var logo: String?
        var fullName: String?
        var fullAddress: String?
        var hotlines: String?
        
        service.makeCall(endpoint: Config.API_APPLIED_STORE_MERCHANT_LIST, method: "POST", header: header as [String: String], body: params, callback: { result in
            
            for i in 0..<result.count {
                
                id = result[i]["id"].int ?? 0
                logo = result[i]["logo"].string ?? ""
                fullName = result[i]["fullName"].string ?? ""
                fullAddress = result[i]["fullAddress"].string ?? ""
                hotlines = result[i]["hotlines"].string ?? ""

                data.append(AppliedStoreMerchantListData(id: id!, logo: logo!, fullName: fullName!, fullAddress: fullAddress!, hotlines: hotlines!))
            
            }
            returnCallBack(data)
        })
    }
}

