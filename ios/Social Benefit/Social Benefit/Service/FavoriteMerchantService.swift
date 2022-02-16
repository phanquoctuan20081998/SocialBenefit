//
//  FavoriteMerchantService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 15/02/2022.
//

import Foundation
import Alamofire

class FavoriteMerchantService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(keyword: String, fromIndex: Int, completion: @escaping (Result<FavoriteMerchantModel, AppError>) -> Void) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId
        ]
        
        let body = FavoriteMerchantRequestModel.init(searchPattern: keyword, fromIndex: fromIndex)
        
        apiRequest.request(url: Config.API_MY_FAVORITE_MERCHANT_LIST, method: .post, headers: header, httpBody: body, type: FavoriteMerchantModel.self) { response in
            completion(response)
        }
    }
}
