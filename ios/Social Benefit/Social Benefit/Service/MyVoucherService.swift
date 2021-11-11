//
//  VoucherService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 22/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class MyVoucherService {
    let dateFomatter = DateFormatter()
    
    init() {
        dateFomatter.dateFormat = "dd/MM/yyyy"
    }
    
    func getAPI(searchPattern: String, fromIndex: Int, status: Int, returnCallBack: @escaping ([MyVoucherData]) -> ()) {
        let service = BaseAPI()
        var data = [MyVoucherData]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters = ["searchPattern": searchPattern,
                                  "fromIndex": fromIndex,
                                  "status": status,
                                  "filterConditionItemsString": ""]
        
        var id: Int?
        var status: Int?
        var voucherOrderId: Int?
        var title: String?
        var cover: String?
        var expriedDate: Date?
        var merchantname: String?
        
        service.makeCall(endpoint: Config.API_MY_VOUCHER, method: "POST", header: header as [String: String], body: params, callback: { result in
            
            for i in 0..<result.count {
                
                id = result[i]["id"].int ?? -1
                status = result[i]["status"].int ?? 0
                voucherOrderId = result[i]["voucher_order_id"].int ?? -1
                title = result[i]["title"].string ?? ""
                cover = result[i]["cover"].string ?? ""
                merchantname = result[i]["merchant"]["fullName"].string ?? ""
                
                let date = result[i]["endTime"].int ?? 0
                expriedDate = Date(timeIntervalSince1970: Double(date / 1000))
                
               
                let tempData = MyVoucherData(id: id!, status: status!, voucherOrderId: voucherOrderId!, title: title!, cover: cover!, expriedDate: expriedDate!, merchantName: merchantname!)
                data.append(tempData)
            }
            returnCallBack(data)
        })
    }
}




