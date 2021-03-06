//
//  ListSurveyModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 25/11/2021.
//

import Foundation

struct ListSurveyModel: APIResponseProtocol {
    var status: Int?
    var result: [SurveyResultModel]?
    var messages: [String]?
}

struct SurveyResultModel: APIModelProtocol, Identifiable, Hashable, Equatable {
    
    var id: Int
    var surveyName: String?
    var deadlineDate: TimeInterval?
    var questionList: [SurveyQuestionList]?
    var deadlinePassed: Bool?
    
    var questionOrderList: [SurveyQuestionList] {
        if let questionList = questionList {
            return questionList.sorted { s1, s2 in
                if let orderNumber1 = s1.orderNumber, let orderNumber2 = s2.orderNumber {
                    return orderNumber1 < orderNumber2
                } else {
                    return true
                }
            }
        }
        return []
    }
    
    var timeRemaining: Int {
        if let deadlineDate = deadlineDate {
            let date = Date.init(timeIntervalSince1970: deadlineDate / 1000)
            return Calendar.current.dateComponents([.hour], from: Date(), to: date).hour ?? 0
        }
        return 0
    }
    
    var surveyNameText: String {
        return surveyName ?? ""
    }
    
    var deadlineText: String {
        var str: String
        if timeRemaining < 72 {
            str = "deadline_soon".localized
        } else {
            str = "deadline".localized
        }
        str += ": "
        str += dateString
        return str
    }
    
    var deadline_edText: String {
        var str = "deadline_ed".localized
        str += ": "
        str += dateString
        return str
    }
    
    var dateString: String {
        if let deadlineDate = deadlineDate {
            let date = Date.init(timeIntervalSince1970: deadlineDate / 1000)
            let df = DateFormatter()
            df.dateFormat = "dd/MM/yyyy HH:mm"
            return df.string(from: date)
        }
        return ""
    }
    
    static func == (lhs: SurveyResultModel, rhs: SurveyResultModel) -> Bool {
        return lhs.id == rhs.id
    }
}


struct SurveyQuestionList: APIModelProtocol, Identifiable, Hashable, Equatable {
   
    var version: Int?
    var active: Bool?
    var id: Int?
    var surveyId: Int?
    var questionName: String?
    var multiAnswer: Bool?
    var mustAnswer: Bool?
    var orderNumber: Int?
    var answerEmployeeCount: Int?
    var choiceList: [SurveyChoiceList]?
    var customAnswer: Bool?
    var totalCustomChoiceCount: Int?
    
    var questionText: String {
        var text = "question".localized
        text += " "
        text += (orderNumber?.string ?? "")
        text += ": "
        text += questionName ?? ""
        return text
    }
    
    static func == (lhs: SurveyQuestionList, rhs: SurveyQuestionList) -> Bool {
        return lhs.id == rhs.id
    }
}

struct SurveyChoiceList: APIModelProtocol, Equatable, Hashable {
    var version: Int?
    var active: Bool?
    var id: Int?
    var questionId: Int?
    var choiceName: String?
    var checked: Bool?
    var numberAnswer: Int?
    var otherChoice: Bool?
    var customAnswer: Bool?
    
    static func == (lhs: SurveyChoiceList, rhs: SurveyChoiceList) -> Bool {
        return lhs.id == rhs.id
    }
}
