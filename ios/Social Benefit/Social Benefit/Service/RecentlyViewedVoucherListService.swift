//
//  RecentlyViewedVoucherListService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 21/02/2022.
//

import Foundation
import Alamofire

class RecentlyViewedVoucherListService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(fromIndex: Int, completion: @escaping (Result<RecentlyVoucherModel, AppError>) -> Void) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId,
            "user_id": userInfor.userId
        ]
        
        let body = RecentlyViewedVoucherRequestModel.init(fromIndex: fromIndex)
        
        apiRequest.request(url: Config.API_RECENT_VIEW_VOUCHER, method: .post, headers: header, httpBody: body, type: RecentlyVoucherModel.self) { response in
            completion(response)
        }
    }
}
