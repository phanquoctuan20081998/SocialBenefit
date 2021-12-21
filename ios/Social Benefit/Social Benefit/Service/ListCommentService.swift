//
//  ListCommentService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 02/12/2021.
//

import Foundation
import Alamofire

class ListCommentService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(contentId: Int, contentType: Int, completion: @escaping ((Result<ListCommentModel, AppError>) -> Void) ) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId,
            "user_id": userInfor.userId,
            "contentId": contentId.string,
            "contentType": contentType.string,
        ]
        
        apiRequest.request(url: Config.API_COMMENT_LIST, method: .post, headers: header, type: ListCommentModel.self) { response in
            completion(response)
        }
    }
}
