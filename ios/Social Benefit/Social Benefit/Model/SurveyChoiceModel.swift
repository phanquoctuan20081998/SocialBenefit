//
//  SurveyChoiceModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 30/11/2021.
//

import Foundation
import Combine
import SwiftUI

struct SurveyChoiceAnswerModel: APIModelProtocol {
    
    var choiceRequestList: [SurveyChoiceModel]?
    
    var questionId: Int?
    
    init() {
        
    }
}

struct SurveyChoiceModel: Codable, Hashable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case choiceId, choiceName, checked
    }
    
    var choiceId: Int?
    var choiceName: String = ""
    var checked: Bool?
    
    var version: Int?
    var active: Bool?
    var id: Int?
    var questionId: Int?
    var numberAnswer: Int?
    var otherChoice: Bool?
    var customAnswer: Bool?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(choiceId, forKey: .choiceId)
        try container.encode(choiceName, forKey: .choiceName)
        try container.encode(checked, forKey: .checked)
    }
    
    var isOption: Bool {
        return choiceId == SurveyDetailViewModel.customId
    }
    
    var isChecked: Bool {
        return checked == true
    }
    
}

struct SurveyChoiceRequestModel: APIModelProtocol {
    var answers: String?
    var surveyId: Int?
    var employeeId: String?
}
