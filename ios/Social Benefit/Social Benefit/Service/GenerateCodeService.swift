//
//  GenerateCodeService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class GenerateCodeService {
    
    func getAPI(voucherId: Int, voucherOrderId: Int, returnCallBack: @escaping (VoucherCodeData) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters = ["voucherId": voucherId,
                                  "voucherOrderId": voucherOrderId]
        
        
        service.makeCall(endpoint: Config.API_GEN_VOUCHER_CODE, method: "POST", header: header as [String: String], body: params, callback: { result in
            let voucherCode = result["voucher_code"].string ?? ""
            let remainTime = (result["remainMillisecondTime"].int ?? 0) / 1000
            
            let data = VoucherCodeData(voucherCode: voucherCode, remainTime: remainTime)
            
            returnCallBack(data)
        })
    }
}
