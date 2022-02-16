//
//  CommentDetailService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 08/02/2022.
//

import Foundation
import Alamofire

class CommentDetailService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(contentId: Int?, completion: @escaping (Result<CommentDetailModel, AppError>) -> Void) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId,
            "companyId" : userInfor.companyId
        ]
        
        apiRequest.request(url: Config.API_COMMENT_GET + "/" + (contentId?.string ?? ""), method: .get, headers: header, type: CommentDetailModel.self) { response in
            completion(response)
        }
    }
}
