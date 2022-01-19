//
//  ReactGroupService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 14/01/2022.
//

import Foundation
import Alamofire

class ReactCountGroupService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(contentType: Int, contentId: Int, completion: @escaping (Result<ReactCountModel, AppError>) -> Void) {
        
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId,
            "companyId": userInfor.companyId,
            "contentType": contentType.string,
            "contentId": contentId.string,
        ]
    
        apiRequest.request(url: Config.API_GET_REACT_COUNT_GROUP, method: .post, headers: header, type: ReactCountModel.self) { response in
            completion(response)
        }
    }
}
