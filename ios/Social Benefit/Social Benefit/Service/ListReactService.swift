//
//  ListReactService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 02/12/2021.
//

import Foundation
import Alamofire

class ListReactService: APIServiceProtocol {
    
    let apiRequest = APIRequest()
    
    func request(contentId: Int?, contentType: Int?, completion: @escaping (Result<ReactSuveryModel, AppError>) -> Void) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId,
            "user_id": userInfor.userId,
            "contentId": contentId?.string ?? "",
            "contentType": contentType?.string ?? "",
        ]
        
        apiRequest.request(url: Config.API_CONTENT_LIST_REACT, method: .post, headers: header, type: ReactSuveryModel.self) { response in
            completion(response)
        }
    }
}
