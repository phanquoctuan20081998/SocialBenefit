//
//  EditCommentSurveySerive.swift
//  Social Benefit
//
//  Created by chu phuong dong on 11/01/2022.
//

import Foundation
import Alamofire

class EditCommentSurveySerive: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(comment: CommentResultModel?, completion: @escaping (Result<AddCommentResultModel, AppError>) -> Void) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId
        ]
        
        let updateComment = UpdateCommentRequestModel.init(comment: comment)
        
        apiRequest.request(url: Config.API_COMMENT_UPDATE, method: .post, headers: header, httpBody: updateComment, type: AddCommentResultModel.self) { response in
            completion(response)
        }
    }
}
