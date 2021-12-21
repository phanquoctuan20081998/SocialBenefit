//
//  AddReactSurveyService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 02/12/2021.
//

import Foundation
import Alamofire

class AddReactSurveyService: APIServiceProtocol {
    
    let apiRequest = APIRequest()
    
    func request(contentId: Int?, contentType: Int?, reactType: ReactionType, completion: @escaping (Result<AddReactResultModel, AppError>) -> Void) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId,
            "user_id": userInfor.userId,
            "contentId": contentId?.string ?? "",
            "contentType": contentType?.string ?? "",
            "reactType": reactType.rawValue.string
        ]
        
        apiRequest.request(url: Config.API_CONTENT_REACT, method: .post, headers: header, type: AddReactResultModel.self) { response in
            completion(response)
        }
    }
}
