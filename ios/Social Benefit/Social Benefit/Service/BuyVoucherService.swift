//
//  BuyVoucherService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 21/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class BuyVoucherService {
    
    func getAPI(voucherId: Int, number: Int, returnCallBack: @escaping (BuyVoucherData) -> ()) {
        
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters = ["voucherId": voucherId,
                                  "number": number]
        
        service.makeCall(endpoint: Config.API_BUY_VOUCHER, method: "POST", header: header as [String: String], body: params, callback: { result in
            
            
            let success = result["success"].bool!
            let message = result["message"].string ?? ""
            let voucherOrderId = result["voucherOrderId"].int ?? -1
            let errorCode = result["errorCode"].string ?? ""
            
            let data = BuyVoucherData(success: success, message: message, voucherOrderId: voucherOrderId, errorCode: errorCode)
    
            returnCallBack(data)
        })
    }
}
