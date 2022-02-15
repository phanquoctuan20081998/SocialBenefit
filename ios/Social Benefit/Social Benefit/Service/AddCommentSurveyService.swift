//
//  AddCommentSurveyService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 02/12/2021.
//

import Foundation
import Alamofire

class AddCommentSurveyService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(replyTo: CommentResultModel?, contentId: Int?, contentType: Int?, content: String, completion: @escaping (Result<AddCommentResultModel, AppError>) -> Void) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId
        ]
        
        let body = AddCommentRequestModel.init(replyTo: replyTo, contentId: contentId, contentType: contentType , content: content)
        
        apiRequest.request(url: Config.API_COMMENT_ADD, method: .post, headers: header, httpBody: body, type: AddCommentResultModel.self) { response in
            completion(response)
        }
    }
}
