//
//  OnboardingVNService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 01/03/2022.
//

import Foundation

class OnboardingVNService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(completion: @escaping (Result<OnboardingModel, AppError>) -> Void) {
        
        apiRequest.request(url: Config.API_ONBOARING_VN, method: .get, type: OnboardingModel.self, debugPrint: false, baseURL: Config.webAdminURL) { response in
            completion(response)
        }
    }
}
