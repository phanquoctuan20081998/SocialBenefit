//
//  OnboardingModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 01/03/2022.
//

import Foundation

struct OnboardingModel: APIResponseProtocol {
    var status: Int?
    var result: [OnboardingResultModel]?
    var messages: [String]?
}

struct OnboardingResultModel: APIModelProtocol, Identifiable, Hashable {
    
    var id: Int {
        return sortOrder
    }
    
    var sortOrder: Int
    var title: String?
    var body: String?
    var image_url: String?
}
