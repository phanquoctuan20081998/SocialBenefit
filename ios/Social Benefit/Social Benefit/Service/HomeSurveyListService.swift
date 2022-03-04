//
//  HomeSurveyListService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 25/02/2022.
//

import Foundation
import Alamofire

class HomeSurveyListService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(completion: @escaping (Result<ListSurveyModel, AppError>) -> Void) {
        
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId,
            "user_id": userInfor.userId,
            "companyId": userInfor.companyId
        ]
        
        apiRequest.request(url: Config.API_HOME_SURVEY, method: .post, headers: header, type: ListSurveyModel.self, debugPrint: false) { response in
            completion(response)
        }
    }
}
