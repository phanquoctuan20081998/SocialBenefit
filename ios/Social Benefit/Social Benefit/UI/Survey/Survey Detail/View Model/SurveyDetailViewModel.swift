//
//  SurveyDetailViewModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 26/11/2021.
//

import Foundation

class SurveyDetailViewModel: ObservableObject {
    
    private let surveyGetSerivce = SurveyGetService()
    private let surveyChoiceSerivce = SurveyChoiceService()
    private let listCommentService = ListCommentService()
    private let addCommentService = AddCommentSurveyService()
    private let reactService = ListReactService()
    
    private let addReactService = AddReactSurveyService()
    
    @Published var surveyModel = SurveyGetModel()
    @Published var isLoading = false
    
    @Published var choiceList: [[SurveyChoiceModel]] = []
    @Published var customList: [[SurveyChoiceModel]] = []
    @Published var hasShowMore: [Bool] = []
    
    @Published var isValidate = false
    
    @Published var isSendingAnswer = false
    
    @Published var commentString = ""
    
    @Published var listComment = ListCommentModel()
    @Published var isSendingComment = false
    
    @Published var replyTo: CommentResultModel?
    
    @Published var isShowReactionBar = false
    
    @Published var currentReaction = ReactionType.none
    
    @Published var reactModel = ReactSuveryModel()
    
    @Published var isLoadingReact = false
    
    private(set) var totalAnswer: [Int] = []
    
    private(set) var maxNumberAnswer: [Int] = []
    
    var deadlinePassed: Bool {
        return surveyModel.result?.deadlinePassed ?? false
    }
    
    static let customId = -1
    
    var questionList: [SurveyQuestionList] {
        return surveyModel.result?.questionOrderList ?? []
    }
    
    func refreshData() {
        replyTo = nil
        commentString = ""
        surveyModel = SurveyGetModel()
        listComment = ListCommentModel()
        isShowReactionBar = false
    }
    
    func request(id: Int) {
        isLoading = true
        surveyGetSerivce.request(id: id) { response in
            switch response {
            case .success(let value):
                self.surveyModel = value
                
                self.surveyModel.result?.questionOrderList.forEach({ question in
                    var list: [SurveyChoiceModel] = []
                    var customAnswerList: [SurveyChoiceModel] = []
                    var total = 0
                    question.choiceList?.forEach({ choice in
                        var choiceModel = SurveyChoiceModel()
                        choiceModel.choiceId = choice.id
                        choiceModel.choiceName = choice.choiceName ?? ""
                        choiceModel.checked = choice.checked
                        
                        choiceModel.version = choice.version
                        choiceModel.active = choice.active
                        choiceModel.questionId = choice.questionId
                        choiceModel.numberAnswer = choice.numberAnswer
                        choiceModel.otherChoice = choice.otherChoice
                        choiceModel.customAnswer = choice.customAnswer
                        
                        if choice.customAnswer == true {
                            customAnswerList.append(choiceModel)
                        } else {
                            list.append(choiceModel)
                        }
                        total += choice.numberAnswer ?? 0
                    })
                    if customAnswerList.count > 1 {
                        self.hasShowMore.append(true)
                    } else {
                        self.hasShowMore.append(false)
                    }
                    if question.customAnswer == true {
                        var choiceModel = SurveyChoiceModel()
                        choiceModel.choiceId = SurveyDetailViewModel.customId
                        choiceModel.choiceName = ""
                        choiceModel.checked = false
                        list.append(choiceModel)
                    }
                    self.choiceList.append(list)
                    self.customList.append(customAnswerList)
                    let max1 = list.map { $0.numberAnswer ?? 0 }.max { n1, n2 in
                        return n1 < n2
                    }
                    
                    let max2 = customAnswerList.map { $0.numberAnswer ?? 0 }.max { n1, n2 in
                        return n1 < n2
                    }
                    let max = max(max1 ?? 0, max2 ?? 0)
                    self.maxNumberAnswer.append(max)
                    self.totalAnswer.append(total)
                })
            case .failure(let error):
                print(error)
            }
            self.isLoading = false
        }
    }
    
    func didTapRadioButton(_ index: Int, posistion: Int, isCustom: Bool) {
        if isCustom {
            for i in 0 ..< choiceList[index].count {
                choiceList[index][i].checked = false
            }
            
            for i in 0 ..< customList[index].count {
                if i != posistion {
                    customList[index][i].checked = false
                }
            }
        } else {
            for i in 0 ..< choiceList[index].count {
                if i != posistion {
                    choiceList[index][i].checked = false
                }
            }
            
            for i in 0 ..< customList[index].count {
                customList[index][i].checked = false
            }
        }
    }
    
    func validate() {
        var result = true
        for (index, question) in questionList.enumerated() {
            if question.mustAnswer == true {
                var didAnswer = false
                choiceList[index].forEach { model in
                    if model.choiceId == SurveyDetailViewModel.customId {
                        if model.choiceName.trimmingCharacters(in: .whitespacesAndNewlines).count > 0, model.checked == true {
                            didAnswer = true
                        }
                    } else {
                        if model.checked == true {
                            didAnswer = true
                        }
                    }
                }
                
                customList[index].forEach { model in
                    if model.choiceId == SurveyDetailViewModel.customId {
                        if model.choiceName.trimmingCharacters(in: .whitespacesAndNewlines).count > 0, model.checked == true {
                            didAnswer = true
                        }
                    } else {
                        if model.checked == true {
                            didAnswer = true
                        }
                    }
                }
                result = (result && didAnswer)
            }
        }
        isValidate = result
    }
    
    var getAllAnswerModel: [SurveyChoiceAnswerModel] {
        var answers: [SurveyChoiceAnswerModel] = []
        for (index, question) in questionList.enumerated() {
            var list: [SurveyChoiceModel] = []
            var answer = SurveyChoiceAnswerModel()
            list.append(contentsOf: choiceList[index])
            list.append(contentsOf: customList[index])
            if question.multiAnswer == nil || question.multiAnswer == false {
                list = list.filter({ model in
                    return model.checked == true
                })
            }
            
            list = list.filter({ model in
                if model.choiceId == SurveyDetailViewModel.customId {
                    if model.choiceName.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return true
                }
            })
            answer.questionId = question.id
            answer.choiceRequestList = list
            answers.append(answer)
        }
        return answers
    }
    
    func sendAnswers() {
        isSendingAnswer = true
        surveyChoiceSerivce.request(answers: getAllAnswerModel, surveyId: surveyModel.result?.id) { response in
            self.isSendingAnswer = false
            switch response {
            case .success(let value):
                if value.status == 200 {
                    self.isValidate = false
                }
            case .failure(_):
                break
            }
        }
    }
    
    func requestListComment(id: Int) {
        listCommentService.request(contentId: id, contentType: 3) { response in
            switch response {
            case .success(let value):
                self.listComment = value
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sendComment() {
        isSendingComment = true
        addCommentService.request(replyTo: replyTo, surveryId: surveyModel.result?.id, content: commentString) { response in
            switch response {
            case.success( let value):
                if value.status == 200 {
                    if let id = self.surveyModel.result?.id {
                        self.requestListComment(id: id)
                    }
                    self.commentString = ""
                    self.replyTo = nil
                }
            case .failure(let error):
                print(error)
            }
            self.isSendingComment = false
        }
    }
    
    func getListReact(id: Int?) {
        isLoadingReact = true
        reactService.request(contentId: id, contentType: 3) { response in
            switch response {
            case .success(let value):
                self.reactModel = value
                self.currentReaction = value.myRectionType
            case .failure(let error):
                print(error)
            }
            self.isLoadingReact = false
        }
    }
    
    func sendReaction() {
        isLoadingReact = true
        addReactService.request(contentId: surveyModel.result?.id, contentType: 3, reactType: currentReaction) { response in
            switch response {
            case .success(let value):
                if value.status == 200 {
                    self.getListReact(id: self.surveyModel.result?.id)
                } else {
                    self.isLoadingReact = false
                }
            case .failure(let error):
                print(error)
                self.isLoadingReact = false
            }
        }
    }
}
