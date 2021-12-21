//
//  SurveyGetService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 29/11/2021.
//

import Foundation
import Alamofire

class SurveyGetService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(id: Int, completion: @escaping ((Result<SurveyGetModel, AppError>) -> Void) ) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "user_id": userInfor.userId,
            "employeeId": userInfor.employeeId]
        
        apiRequest.request(url: Config.API_SURVEY_GET + "/" + String(id), method: .get, headers: header, type: SurveyGetModel.self) { response in
            completion(response)
        }
    }
}
