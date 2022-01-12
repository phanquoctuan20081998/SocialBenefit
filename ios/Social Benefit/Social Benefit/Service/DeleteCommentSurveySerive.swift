//
//  DeleteCommentSurvey.swift
//  Social Benefit
//
//  Created by chu phuong dong on 11/01/2022.
//

import Foundation
import Alamofire

class DeleteCommentSurveySerive: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(comment: CommentResultModel?, completion: @escaping (Result<AddCommentResultModel, AppError>) -> Void) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId
        ]
    
        apiRequest.request(url: Config.API_COMMENT_DELETE, method: .post, headers: header, httpBody: comment, type: AddCommentResultModel.self) { response in
            completion(response)
        }
    }
}
