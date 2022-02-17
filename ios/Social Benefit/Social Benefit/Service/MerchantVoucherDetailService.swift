//
//  MerchantVoucherDetailService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class MerchantVoucherDetailService {
    
    func getAPI(merchantVoucherId: Int, returnCallBack: @escaping (MerchantVoucherDetailData) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters = ["merchantVoucherId": merchantVoucherId]
        
        print(merchantVoucherId)
        service.makeCall(endpoint: Config.API_MERCHANT_VOUCHER_DETAIL, method: "POST", header: header as [String: String], body: params, callback: { result in
            print(result)
            let id = result["id"].int ?? 0
            let imageURL = result["imageURL"].string ?? ""
            let name = result["name"].string ?? ""
            let merchantName = result["merchantName"].string ?? ""
            let content = result["content"].string ?? ""
            let favoriteValue = result["favoriteValue"].int ?? 0
            let outOfDate = result["outOfDateTime"].string ?? ""
            let shoppingValue = result["shoppingValue"].int ?? 0
            let pointValue = result["pointValue"].int64 ?? 0
            let moneyValue = result["moneyValue"].int64 ?? 0
            let discountValue = result["discountValue"].int ?? 0
            let hotlines = result["hotlines"].string ?? ""
            let employeeLikeThis = result["employeeLikeThis"].bool ?? false
            let employeeLikeThisMerchant = result["employeeLikeThisMerchant"].bool ?? false
            let merchantId = result["merchantId"].int ?? 0
            
            let data = MerchantVoucherDetailData(id: id, imageURL: imageURL, name: name, merchantName: merchantName, content: content, favoriteValue: favoriteValue, outOfDate: outOfDate, shoppingValue: shoppingValue, pointValue: pointValue, moneyValue: moneyValue, discountValue: discountValue, hotlines: hotlines, employeeLikeThis: employeeLikeThis, employeeLikeThisMerchant: employeeLikeThisMerchant, merchantId: merchantId)
            
            returnCallBack(data)
        })
    }
}
