//
//  MerchantVoucherListByMerchantService.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 15/02/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class MerchantVoucherListByMerchantService {
    
    let dateFomatter = DateFormatter()
    
    init() {
        dateFomatter.dateFormat = "dd/MM/yyyy"
    }
    
    func getAPI(merchantId: Int, returnCallBack: @escaping ([MerchantVoucherItemData]) -> ()) {
        let service = BaseAPI()
        var data = [MerchantVoucherItemData]()
        
        let header = ["token": userInfor.token,
                      "user_id": userInfor.userId]
        
        let params: Parameters = ["merchantId": merchantId]
        
        var id: Int = 0
        var voucherCode: Int = 0
        var imageURL: String = ""
        var name: String = ""
        var merchantName: String = ""
        var content: String = ""
        var favoriteValue: Int = 0
        var outOfDateTime: Date = Date()
        var shoppingValue: Int = 0
        var pointValue: Int64 = 0
        var moneyValue: Int64 = 0
        var discountValue: Int = 0
        var categoryId: Int = 0
        var merchantId: Int = 0
        var employeeLikeThis: Bool = false
        
        service.makeCall(endpoint: Config.API_MERCHANT_LIST_BY_MERCHANT, method: "POST", header: header as [String: String], body: params, callback: { result in
            
            for i in 0..<result.count {
                
                id = result[i]["id"].int ?? -1
                voucherCode = result[i]["voucherCode"].int ?? 0
                imageURL = result[i]["imageURL"].string ?? ""
                name = result[i]["name"].string ?? ""
                merchantName = result[i]["merchantName"].string ?? ""
                content = result[i]["content"].string ?? ""
                favoriteValue = result[i]["favoriteValue"].int ?? 0
                outOfDateTime = self.dateFomatter.date(from: result[i]["outOfDateTime"].string ?? "00/00/0000") ?? Date()
                shoppingValue = result[i]["shoppingValue"].int ?? 0
                pointValue = result[i]["pointValue"].int64 ?? 0
                moneyValue = result[i]["moneyValue"].int64 ?? 0
                discountValue = result[i]["discountValue"].int ?? 0
                categoryId = result[i]["categoryId"].int ?? -1
                merchantId = result[i]["merchantId"].int ?? -1
                employeeLikeThis = result[i]["employeeLikeThis"].bool ?? false
                
                let tempMerchantVoucherItemData = MerchantVoucherItemData(id: id, voucherCode: voucherCode, imageURL: imageURL, name: name, merchantName: merchantName, content: content, favoriteValue: favoriteValue, outOfDateTime: outOfDateTime, shoppingValue: shoppingValue, pointValue: pointValue, moneyValue: moneyValue, discountValue: discountValue, categoryId: categoryId, merchantId: merchantId, employeeLikeThis: employeeLikeThis)
                
                data.append(tempMerchantVoucherItemData)
            }
            returnCallBack(data)
        })
    }
}



