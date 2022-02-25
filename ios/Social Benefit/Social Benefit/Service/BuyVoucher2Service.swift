//
//  BuyVoucher2Service.swift
//  Social Benefit
//
//  Created by chu phuong dong on 22/02/2022.
//

import Foundation
import Alamofire

class BuyVoucher2Service: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(voucherId: Int?, number: Int?, beforeBuyVoucherOrderCount: Int? , completion: @escaping (Result<BuyVoucherModel, AppError>) -> Void) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId,
            "user_id": userInfor.userId
        ]
        
        let body = BuyVoucherRequestModel.init(voucherId: voucherId, number: number, beforeBuyVoucherOrderCount: beforeBuyVoucherOrderCount)
        apiRequest.request(url: Config.API_BUY_VOUCHER, method: .post, headers: header, httpBody: body, type: BuyVoucherModel.self) { response in
            completion(response)
        }
    }
}
