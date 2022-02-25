//
//  BuyInforVoucherService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 22/02/2022.
//

import Foundation
import Alamofire

class BuyInforVoucherService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(voucherId: Int, completion: @escaping (Result<BuyInforVoucherModel, AppError>) -> Void) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId,
        ]
        
        apiRequest.request(url: Config.API_CONFIRM_BUY_VOUCHER + "/\(voucherId)", method: .get, headers: header, type: BuyInforVoucherModel.self) { response in
            completion(response)
        }
    }
}

