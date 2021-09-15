//
//  MerchantCategoryItemService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON
    
class MerchantCategoryItemService {
    
    @Published var data = [MerchantCategoryItemData]()
    
    init() {
        self.getAPI { data in
            self.data = data
        }
    }
    
   func getAPI(returnCallBack: @escaping ([MerchantCategoryItemData]) -> ()) {
        let service = BaseAPI()
        var data = [MerchantCategoryItemData]()
        
        let header = ["token": userInfor.token]
        
        let params: Parameters = ["": ""]
        
        var id: Int?
        var imgSrc: String?
        var title: String?
        
        service.makeCall(endpoint: Constant.API_MERCHANT_CATEGORY, method: "POST", header: header as [String : String], body: params, callback: { result in
            for i in 0..<result.count {
                id = result[i]["id"].int ?? 0
                imgSrc = result[i]["imgSrc"].string ?? ""
                title = result[i]["title"].string ?? ""
               
                let tempMerchantCategoryItemData = MerchantCategoryItemData(id: id!, imgSrc: imgSrc!, title: title!)
                data.append(tempMerchantCategoryItemData)
            }
            returnCallBack(data)
        })
    }
}
