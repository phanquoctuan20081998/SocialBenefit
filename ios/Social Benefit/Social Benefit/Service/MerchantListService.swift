//
//  MerchantListService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/08/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON
    
class MerchantListService {
    
    func getAPI(returnCallBack: @escaping ([MerchantListData]) -> ()) {
        let service = BaseAPI()
        var data = [MerchantListData]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters = ["": ""]
        
        var id: Int?
        var name: String?
        var cover: String?
        
        service.makeCall(endpoint: Config.API_MERCHANT_LIST_SPECIAL, method: "POST", header: header as [String : String], body: params, callback: { result in
            for i in 0..<result.count {
                id = result[i]["id"].int ?? 0
                name = result[i]["name"].string ?? ""
                cover = result[i]["imageURL"].string ?? ""
               
                let tempInternalNewsData = MerchantListData(id: id ?? 0, name: name ?? "", cover: cover ?? "")
                data.append(tempInternalNewsData)
            }
            returnCallBack(data)
        })
    }
}
