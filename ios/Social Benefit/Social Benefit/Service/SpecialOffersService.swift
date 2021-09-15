//
//  SpecialOffersService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class SpecialOffersService {
    let dateFomatter = DateFormatter()
    
    init() {
        dateFomatter.dateFormat = "dd/MM/yyyy"
    }
    
    func getAPI(searchPattern: String, fromIndex: Int, categoryId: Int, returnCallBack: @escaping ([MerchantVoucherItemData]) -> ()) {
        let service = BaseAPI()
        var data = [MerchantVoucherItemData]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters = ["searchPattern": searchPattern,
                                  "fromIndex": "",
                                  "categoryId": ""]
        
        var id: Int?
        var voucherCode: Int?
        var imageURL: String?
        var name: String?
        var merchantName: String?
        var content: String?
        var favoriteValue: Int?
        var outOfDateTime: Date?
        var shoppingValue: Int?
        var pointValue: Int64?
        var moneyValue: Int64?
        var discountValue: Int?
        var categoryId: Int?
        var merchantId: Int?
        var employeeLikeThis: Bool?
        
        service.makeCall(endpoint: Constant.API_MERCHANT_LIST_SPECIAL, method: "POST", header: header as [String: String], body: params, callback: { result in
            
            for i in 0..<result.count {
                
                id = result[i]["id"].int ?? -1
                voucherCode = result[i]["voucherCode"].int ?? 0
                imageURL = result[i]["imageURL"].string ?? ""
                name = result[i]["name"].string ?? ""
                merchantName = result[i]["merchantName"].string ?? ""
                content = result[i]["content"].string ?? ""
                favoriteValue = result[i]["favoriteValue"].int ?? 0
                outOfDateTime = self.dateFomatter.date(from: result[i]["outOfDateTime"].string ?? "00/00/0000")
                shoppingValue = result[i]["shoppingValue"].int ?? 0
                pointValue = result[i]["pointValue"].int64 ?? 0
                moneyValue = result[i]["moneyValue"].int64 ?? 0
                discountValue = result[i]["discountValue"].int ?? 0
                categoryId = result[i]["categoryId"].int ?? -1
                merchantId = result[i]["merchantId"].int ?? -1
                employeeLikeThis = result[i]["employeeLikeThis"].bool ?? false
               
                let tempMerchantVoucherItemData = MerchantVoucherItemData(id: id!, voucherCode: voucherCode!, imageURL: imageURL!, name: name!, merchantName: merchantName!, content: content!, favoriteValue: favoriteValue!, outOfDateTime: outOfDateTime!, shoppingValue: shoppingValue!, pointValue: pointValue!, moneyValue: moneyValue!, discountValue: discountValue!, categoryId: categoryId!, merchantId: merchantId!, employeeLikeThis: employeeLikeThis!)
                
                data.append(tempMerchantVoucherItemData)
            }
            returnCallBack(data)
        })
    }
}


