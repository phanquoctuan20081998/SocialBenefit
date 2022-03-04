//
//  OnboardingService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 01/03/2022.
//

import Foundation
import Alamofire

class OnboardingService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(completion: @escaping (Result<OnboardingModel, AppError>) -> Void) {
        
        apiRequest.request(url: Config.API_ONBOARING, method: .get, type: OnboardingModel.self, debugPrint: false, baseURL: Config.webAdminURL) { response in
            completion(response)
        }
    }
}
