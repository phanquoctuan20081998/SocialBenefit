//
//  FavoriteUpdateMerchantService.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 17/02/2022.
//

import Foundation
import Alamofire

class FavoriteMerchantUpdateService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(merchantId: Int, likeMerchant: Bool) -> Void {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId
        ]
        
        let body = FavoriteMerchantUpdateRequestModel.init(merchantId: merchantId, employeeId: userInfor.employeeId, likeMerchant: likeMerchant)
        
        apiRequest.request(url: Config.API_UPDATE_MY_FAVORITE_MERCHANT_LIST, method: .post, headers: header, httpBody: body, type: FavoriteMerchantModel.self) { response in
            print(response)
        }
    }
}

