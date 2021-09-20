//
//  ConfirmInforBuyService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 20/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON
    
class ConfirmInforBuyService {
    
    private var voucherId: Int
    
    init(voucherId: Int) {
        self.voucherId = voucherId
    }
    
    func getAPI(returnCallBack: @escaping (BuyVoucherInforData) -> ()) {
        let service = BaseAPI_Alamofire()
    
        let endPoint = Config.API_CONFIRM_BUY_VOUCHER + "/\(self.voucherId)"
        let header: HTTPHeaders = ["token": userInfor.token,
                                   "employeeId" : userInfor.employeeId]
        let params: Parameters = ["":""]

        service.makeCall(endpoint: endPoint, method: "GET", header: header, body: params, callback: { result in
            
            print(result)
            
            let remainPoint = result["remainPoint"].int ?? -1
            let voucherPoint = result["voucherPoint"].int ?? -1
            let canUseNumber = result["canUseNumber"].int ?? -1
            let maxCanBuyNumber = result["maxCanBuyNumber"].int ?? -1
            let orderedNumber = result["orderedNumber"].int ?? -1
            let remainVoucherInStock = result["remainVoucherInStock"].int ?? -1
               
            let data = BuyVoucherInforData(remainPoint: remainPoint, voucherPoint: voucherPoint, canUseNumber: canUseNumber, maxCanBuyNumber: maxCanBuyNumber, orderedNumber: orderedNumber, remainVoucherInStock: remainVoucherInStock)
                   
            returnCallBack(data)
        })
    }
}
