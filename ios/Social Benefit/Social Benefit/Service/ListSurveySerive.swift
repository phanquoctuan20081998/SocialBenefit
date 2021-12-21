//
//  ListSurveySerive.swift
//  Social Benefit
//
//  Created by chu phuong dong on 25/11/2021.
//

import Foundation
import Alamofire

enum SurveyStatus: Int {
    case onGoing = 0
    case finished = 1
}

class ListSurveySerive: APIServiceProtocol {
    
    let apiRequest = APIRequest()
    
    func request(keyword: String = "", flag: SurveyStatus = .onGoing, completion: @escaping ((Result<ListSurveyModel, AppError>) -> Void) ) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "user_id": userInfor.userId,
            "employeeId": userInfor.employeeId]
        
        let body = ListSurveyRequestModel.init(keyword: keyword, flag: flag.rawValue)
        
        apiRequest.request(url: Config.API_SURVEY_LIST, headers: header, httpBody: body, type: ListSurveyModel.self) { response in
            completion(response)
        }
    }
}
