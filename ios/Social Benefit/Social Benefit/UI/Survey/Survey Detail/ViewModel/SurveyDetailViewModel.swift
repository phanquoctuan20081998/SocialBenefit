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
    
    private let deleteCommentService = DeleteCommentSurveySerive()
    private let editCommentService = EditCommentSurveySerive()
    
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
    
    @Published var sendAnswerSuccess = ""
    
    @Published var error: AppError = .none
    
    @Published var focusComment = false
    
    @Published var commentSelected: CommentResultModel? = nil
    
    @Published var commentEdited: CommentResultModel? = nil
    
    @Published var commentDeleted: CommentResultModel? = nil
    
    @Published var newComment = ""
    
    @Published var scrollToBottom = false
    
    @Published var infoText = ""
    
    private(set) var totalAnswer: [Int] = []
    
    private(set) var maxNumberAnswer: [Int] = []
    
    var deadlinePassed: Bool {
        return surveyModel.result?.deadlinePassed ?? false
    }
    
    static let customId = -1
    
    var questionList: [SurveyQuestionList] = []
    
    private var currentChoiceList: [[SurveyChoiceModel]] = []
    private var currentCustomList: [[SurveyChoiceModel]] = []
    
    func refreshData() {
        replyTo = nil
        commentString = ""
        surveyModel = SurveyGetModel()
        listComment = ListCommentModel()
        isShowReactionBar = false
        sendAnswerSuccess = ""
        error = .none
        newComment = ""
        commentSelected = nil
        commentEdited = nil
        commentDeleted = nil
        scrollToBottom = false
        infoText = ""
    }
    
    func request(id: Int, showLoading: Bool = true) {
        if showLoading {
            isLoading = true
        }
        
        surveyGetSerivce.request(id: id) { response in
            switch response {
            case .success(let value):
                var hasShowMoreTemp: [Bool] = []
                var choiceListTemp: [[SurveyChoiceModel]] = []
                var customListTemp: [[SurveyChoiceModel]] = []
                var maxNumberAnswerTemp: [Int] = []
                var totalAnswerTemp: [Int] = []
                value.result?.questionOrderList.forEach({ question in
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
                        hasShowMoreTemp.append(true)
                    } else {
                        hasShowMoreTemp.append(false)
                    }
                    if question.customAnswer == true {
                        var choiceModel = SurveyChoiceModel()
                        choiceModel.choiceId = SurveyDetailViewModel.customId
                        choiceModel.choiceName = ""
                        choiceModel.checked = false
                        list.append(choiceModel)
                    }
                    choiceListTemp.append(list)
                    customListTemp.append(customAnswerList)
                    let max1 = list.map { $0.numberAnswer ?? 0 }.max { n1, n2 in
                        return n1 < n2
                    }
                    
                    let max2 = customAnswerList.map { $0.numberAnswer ?? 0 }.max { n1, n2 in
                        return n1 < n2
                    }
                    let max = max(max1 ?? 0, max2 ?? 0)
                    maxNumberAnswerTemp.append(max)
                    totalAnswerTemp.append(total)
                })
                self.hasShowMore = hasShowMoreTemp
                self.choiceList = choiceListTemp
                self.customList = customListTemp
                self.currentChoiceList = choiceListTemp
                self.currentCustomList = customListTemp
                self.maxNumberAnswer = maxNumberAnswerTemp
                self.totalAnswer = totalAnswerTemp
                self.questionList = value.result?.questionOrderList ?? []
                self.surveyModel = value
            case .failure(let error):
                self.error = error
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
            
            if result {
                let compare1 = choiceList.elementsEqual(currentChoiceList, by: { $0 == $1 })
                let compare2 = customList.elementsEqual(currentCustomList, by: { $0 == $1 })
                
                if compare1, compare2 {
                    result = false
                }
            }
        }
        
        isValidate = result
    }
    
    func validateCustomAnswer() -> Bool {
        for (index, question) in questionList.enumerated() {
            if question.customAnswer == true {
                for choice in choiceList[index] {
                    if choice.choiceId == SurveyDetailViewModel.customId, choice.choiceName.trimmingCharacters(in: .whitespacesAndNewlines).count == 0, choice.checked == true {
                        return false
                    }
                }
            }
        }
        return true
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
        sendAnswerSuccess = ""
        infoText = ""
        Utils.dismissKeyboard()
        if !validateCustomAnswer() {
            infoText = "not_complete_survey_error".localized
        } else {
            isSendingAnswer = true
            surveyChoiceSerivce.request(answers: getAllAnswerModel, surveyId: surveyModel.result?.id) { response in
                self.isSendingAnswer = false
                switch response {
                case .success(let value):
                    if value.status == 200 {
                        self.isValidate = false
                        self.sendAnswerSuccess = "survey_answer_updated".localized
                        if let id = self.surveyModel.result?.id {
                            self.request(id: id, showLoading: false)
                        }
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    func requestListComment(id: Int, completion: (() -> Void)? = nil) {
        listCommentService.request(contentId: id, contentType: 3) { response in
            switch response {
            case .success(let value):
                self.listComment = value
                completion?()
            case .failure(let error):
                self.error = error
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
                        self.requestListComment(id: id) {
                            self.scrollToBottom = true
                        }
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
                self.error = error
                self.isLoadingReact = false
            }
        }
    }
    
    func didLongTapCommnet(_ comment: CommentResultModel) {
        if comment.commentByEmployeeId?.string == userInfor.employeeId {
            Utils.dismissKeyboard()
            commentSelected = comment
        }
    }
    
    func deleteComment() {
        if let comment = commentDeleted {
            isLoading = true
            deleteCommentService.request(comment: comment) { response in
                switch response {
                case .success(_):
                    self.listComment.deleteComment(comment: comment)
                    self.commentDeleted = nil
                case .failure(let error):
                    self.error = error
                }
                self.isLoading = false
            }
        }
    }
    
    func updateComment() {
        if var comment = commentEdited {
            comment.commentDetail = newComment
            isLoading = true
            editCommentService.request(comment: comment) { response in
                switch response {
                case .success(_):
                    self.listComment.updateComment(comment: comment)
                    self.commentEdited = nil
                case .failure(let error):
                    self.error = error
                }
                self.isLoading = false
            }
        }
    }
}
