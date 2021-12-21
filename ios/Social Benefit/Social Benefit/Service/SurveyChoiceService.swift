//
//  SurveyChoiceService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 30/11/2021.
//

import Foundation
import Alamofire

class SurveyChoiceService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(answers: [SurveyChoiceAnswerModel], surveyId: Int?, completion: @escaping ((Result<SurveyChoiceResultModel, AppError>) -> Void) ) {
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId]
        
        var body = SurveyChoiceRequestModel()
        let data = try? JSONEncoder().encode(answers)
        var jsonAnswers = ""
        if let data = data, let json = String(data: data, encoding: .utf8) {
            jsonAnswers = json
        }
        body.answers = jsonAnswers
        body.surveyId = surveyId
        body.employeeId = userInfor.employeeId
        
        apiRequest.request(url: Config.API_SURVEY_CHOICE, method: .post, headers: header, httpBody: body, type: SurveyChoiceResultModel.self) { response in
            completion(response)
        }
    }
}
