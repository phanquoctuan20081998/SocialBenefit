//
//  SurveyDetailViewModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 26/11/2021.
//

import SwiftUI

enum ReactActiveSheet: Identifiable {
    case content, comment
    
    var id: ReactActiveSheet { self }
}

struct SurveyDetailView: View {
    
    let contentId: Int
    
    @StateObject private var viewModel = SurveyDetailViewModel()
    
    @StateObject var commentEnvironment = CommentEnvironmentObject()
    
    @State var activeSheet: ReactActiveSheet?
    
    init(contentId: Int) {
        self.contentId = contentId
    }
    
    var body: some View {
        survetList
        .background(BackgroundViewWithoutNotiAndSearch(isActive: Binding.constant(false), title: "", isHaveLogo: true))
        .onAppear() {
            viewModel.refreshData()
            viewModel.request(id: contentId)
            viewModel.getListReact(id: contentId)
            UIScrollView.appearance().keyboardDismissMode = .onDrag
        }
        .onTapGesture {
            if viewModel.isShowReactionBar {
                viewModel.isShowReactionBar = false
            }
            viewModel.sendAnswerSuccess = ""
            viewModel.infoText = ""
            Utils.dismissKeyboard()
        }
        .navigationBarHidden(true)
        .successPopup($viewModel.sendAnswerSuccess)
        .overlay(CommentPopup().environmentObject(commentEnvironment))
        .overlay(DeleteCommentPopup().environmentObject(commentEnvironment))
        .overlay(EditCommentPopup().environmentObject(commentEnvironment))
        .overlay(CommentReactPopup().environmentObject(commentEnvironment))
        .errorPopup($viewModel.error)
        .errorPopup($commentEnvironment.error)
        .loadingView(isLoading: $viewModel.isLoading, dimBackground: false)
        .inforTextView($viewModel.infoText)
        .sheet(item: $activeSheet) { item in
            switch item {
            case .content:
                ReactionPopUpView(activeSheet: $activeSheet, contentType: Constants.CommentContentType.COMMENT_TYPE_SURVEY, contentId: contentId)
            case .comment:
                ReactionPopUpView(activeSheet: $activeSheet, contentType: Constants.CommentContentType.COMMENT_TYPE_COMMENT, contentId: commentEnvironment.commentId)
            }
        }
    }
    
    var survetList: some View {
        VStack {
            if let survey = viewModel.surveyModel.result {
                VStack {
                    Spacer()
                        .frame(height: 50)
                    ScrollView {
                        
                        HStack() {
                            Spacer()
                                .frame(width: 20)
                            VStack {
                                Text(survey.surveyNameText)
                                    .foregroundColor(Color("color_top3"))
                                    .bold()
                                Divider()
                                    .background(Color("color_top3"))
                                HStack {
                                    Text("end_date_survey".localized)
                                        .font(Font.system(size: 14))
                                    Text(survey.dateString)
                                        .foregroundColor(Color.red)
                                        .font(Font.system(size: 14))
                                }
                                
                                surveyChoiceList
                                
                                if !viewModel.deadlinePassed {
                                    if viewModel.isSendingAnswer {
                                        HStack {
                                            ActivityRep()
                                            Text("sending".localized)
                                        }
                                    } else {
                                        Button.init( action: {
                                            viewModel.sendAnswers()
                                        }, label: {
                                            let color = viewModel.isValidate ? Color("nissho_light_blue") : Color.gray
                                            Text("send".localized)
                                                .foregroundColor(.black)
                                                .padding(.init(top: 10, leading: 50, bottom: 10, trailing: 50))
                                                .background(
                                                    RoundedRectangle(cornerRadius: 10).fill(color)
                                                )
                                                .font(.system(size: 15))
                                        }).disabled(!viewModel.isValidate)
                                    }
                                }
                            }
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.2), radius: 8, x: -3, y: 3)
                            Spacer()
                                .frame(width: 20)
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        reactionView
        
                        commentList
                    }
                    .introspectScrollView { scrollView in
                        if commentEnvironment.scrollToBottom {
                            if scrollView.contentSize.height > scrollView.bounds.size.height {
                                let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
                                scrollView.setContentOffset(bottomOffset, animated: true)
                            }
                        }
                    }
                }
                
                commentBar
                
            } else {
                Color.clear
            }
        }
    }
    
    var surveyChoiceList: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(viewModel.questionList.indices) { index in
                let question = viewModel.questionList[index]
                let multiAnswer = question.multiAnswer ?? false
                
                HStack {
                    if question.mustAnswer == true {
                        (Text(question.questionText) + Text(" ") + Text("*").foregroundColor(Color.red))
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text(question.questionText)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 0, trailing: 0))
                
                ForEach(viewModel.choiceList[index].indices) { idx in
                    if viewModel.deadlinePassed {
                        if viewModel.choiceList[index][idx].choiceId != SurveyDetailViewModel.customId {
                            HStack {
                                if viewModel.choiceList[index][idx].numberAnswer == viewModel.maxNumberAnswer[index], viewModel.maxNumberAnswer[index] > 0 {
                                    
                                    Text(viewModel.choiceList[index][idx].choiceName)
                                        .bold()
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                    let number = viewModel.choiceList[index][idx].numberAnswer?.string ?? "0"
                                    Text(number + " " + "answer".localized)
                                        .bold()
                                } else {
                                    Text(viewModel.choiceList[index][idx].choiceName)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                    let number = viewModel.choiceList[index][idx].numberAnswer?.string ?? "0"
                                    Text(number + " " + "answer".localized)
                                }
                            }
                            .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                        }
                        else {
                            EmptyView()
                        }
                    } else {
                        HStack {
                            if multiAnswer {
                                CheckBoxOptional(model: $viewModel.choiceList[index][idx], action: {
                                    self.viewModel.validate()
                                })
                            } else {
                                RadioButtonOptional(model: $viewModel.choiceList[index][idx], action: {
                                    self.viewModel.didTapRadioButton(index, posistion: idx, isCustom: false)
                                    self.viewModel.validate()
                                })
                            }
                            if viewModel.choiceList[index][idx].isOption {
                                TextField("", text: $viewModel.choiceList[index][idx].choiceName.onChange({ value in
                                    self.viewModel.validate()
                                }))
                                    .textFieldStyle(.roundedBorder)
                            }
                        }
                        .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                    }
                }
                
                if viewModel.deadlinePassed {
                    if viewModel.customList[index].count > 0 {
                        HStack {
                            let numberOther = question.totalCustomChoiceCount?.string ?? "0"
                            Text("other".localized + ":")
                            Spacer()
                            Text(numberOther + " " + "answer".localized)
                        }
                        .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                    }
                }
                
                if viewModel.hasShowMore[index] {
                    HStack() {
                        if viewModel.deadlinePassed {
                            Text(viewModel.customList[index][0].choiceName)
                            Spacer()
                            let number = viewModel.customList[index][0].numberAnswer?.string ?? "0"
                            Text(number + " " + "answer".localized)
                        } else {
                            if multiAnswer {
                                CheckBoxOptional(model: $viewModel.customList[index][0], action: {
                                    self.viewModel.validate()
                                })
                            } else {
                                RadioButtonOptional(model: $viewModel.customList[index][0]) {
                                    self.viewModel.didTapRadioButton(index, posistion: 0, isCustom: true)
                                    self.viewModel.validate()
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 10))
                    HStack() {
                        Spacer()
                        Button.init(action: {
                            viewModel.hasShowMore[index] = false
                        }, label: {
                            Text("show_more").font(Font.system(size: 14))
                        })
                        Spacer()
                    }
                    
                } else {
                    ForEach(viewModel.customList[index].indices) { idx in
                        HStack() {
                            if viewModel.deadlinePassed {
                                Text(viewModel.customList[index][idx].choiceName)
                                Spacer()
                                let number = viewModel.customList[index][idx].numberAnswer?.string ?? "0"
                                Text(number + " " + "answer".localized)
                            } else {
                                if multiAnswer {
                                    CheckBoxOptional(model: $viewModel.customList[index][idx], action: {
                                        self.viewModel.validate()
                                    })
                                } else {
                                    RadioButtonOptional(model: $viewModel.customList[index][idx]) {
                                        self.viewModel.didTapRadioButton(index, posistion: idx, isCustom: true)
                                        self.viewModel.validate()
                                    }
                                }
                            }
                        }
                        .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 10))
                    }
                }
                
                if viewModel.deadlinePassed {
                    HStack {
                        Text("total".localized + ":")
                        Text(viewModel.totalAnswer[index].string + " " + "answer".localized)
                    }
                    .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var commentBar: some View {
        CommentInputView(contentId: contentId, contentType: Constants.CommentContentType.COMMENT_TYPE_SURVEY)
            .environmentObject(commentEnvironment)
    }
    
    var commentList: some View {
        CommentListView.init(contentId: contentId, contentType: Constants.CommentContentType.COMMENT_TYPE_SURVEY, activeSheet: $activeSheet)
            .environmentObject(commentEnvironment)
    }
    
    var reactionView: some View {
        
        ReactionBar(isShowReactionBar: $viewModel.isShowReactionBar,
                    isLoadingReact: $viewModel.isLoadingReact,
                    currentReaction: $viewModel.currentReaction,
                    isFocus: $commentEnvironment.focusComment,
                    activeSheet:$activeSheet,
                    reactModel: viewModel.reactModel,
                    listComment: commentEnvironment.listComment,
                    sendReaction: self.viewModel.sendReaction)
    }
}
