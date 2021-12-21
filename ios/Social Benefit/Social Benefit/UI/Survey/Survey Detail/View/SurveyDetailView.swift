//
//  SurveyDetailViewModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 26/11/2021.
//

import SwiftUI

struct SurveyDetailView: View {
    
    let detailModel: SurveyResultModel
    
    @ObservedObject private var viewModel = SurveyDetailViewModel()
    
    var body: some View {
        survetList
        .background(BackgroundViewWithoutNotiAndSearch(isActive: Binding.constant(false), title: "", isHaveLogo: true))
        .onAppear() {
            viewModel.refreshData()
            viewModel.request(id: detailModel.id)
            viewModel.requestListComment(id: detailModel.id)
            viewModel.getListReact(id: detailModel.id)
            UIScrollView.appearance().keyboardDismissMode = .onDrag
        }
        .navigationBarHidden(true)
    }
    
    var survetList: some View {
        VStack {
            if viewModel.isLoading {
                LoadingPageView()
            } else {
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
                                        Text("deadline".localized + ":")
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
                            Spacer()
                                .frame(height: 20)
                            reactionView
                            commentList
                        }
                    }
                    
                    commentBar
                    
                } else {
                    EmptyView()
                }
            }
        }
    }
    
    var surveyChoiceList: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(viewModel.questionList.indices) { index in
                let question = viewModel.questionList[index]
                let multiAnswer = question.multiAnswer ?? false
                HStack {
                    Text(question.questionText)
                    if question.mustAnswer == true {
                        Text("*").foregroundColor(Color.red)
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
                                    Spacer()
                                    let number = viewModel.choiceList[index][idx].numberAnswer?.string ?? "0"
                                    Text(number + " " + "answer".localized)
                                        .bold()
                                } else {
                                    Text(viewModel.choiceList[index][idx].choiceName)
                                    Spacer()
                                    let number = viewModel.choiceList[index][idx].numberAnswer?.string ?? "0"
                                    Text(number + " " + "answer".localized)
                                }
                            }
                            .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                        } else {
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
        VStack(alignment: .leading) {
            Divider()
            HStack(alignment: .center, spacing: 10) {
                URLImageView(url: Config.baseURL + userInfor.avatar)
                    .clipShape(Circle())
                    .frame(width: 20, height: 20)
                    .padding(.all, 7)
                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                
                VStack(alignment: .leading) {
                    if viewModel.replyTo != nil {
                        HStack {
                            Text("reply_to".localized)
                                .font(Font.system(size: 12))
                            Text(viewModel.replyTo?.commentBy ?? "")
                                .font(Font.system(size: 12))
                            Text("-")
                                .font(Font.system(size: 12))
                            Button.init {
                                viewModel.replyTo = nil
                            } label: {
                                Text("cancel".localized)
                                    .font(Font.system(size: 12))
                            }
                            
                        }
                    }
                    HStack {
                        TextField("type_comment".localized, text: $viewModel.commentString)
                            .textFieldStyle(.roundedBorder)
                            .disabled(viewModel.isSendingComment)
                        if viewModel.isSendingComment {
                            ActivityRep()
                        } else {
                            Button.init {
                                Utils.dismissKeyboard()
                                viewModel.sendComment()
                            } label: {
                                Image.init(systemName: "paperplane")
                            }
                            .disabled(viewModel.commentString.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
                        }
                    }
                }
                
            }
            .background(Color.white)
            .padding(10)
        }
    }
    
    var commentList: some View {
        VStack(alignment: .leading) {
            ForEach(viewModel.listComment.comments) { comment in
                HStack(alignment: .top) {
                    URLImageView(url: Config.baseURL + (comment.avatar ?? ""))
                        .clipShape(Circle())
                        .frame(width: 30, height: 30)
                        .padding(.all, 5)
                        .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                    
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(comment.commentBy ?? "")
                                .bold()
                                .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                .font(Font.system(size: 14))
                            Text(comment.commentDetail ?? "")
                                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                                .font(Font.system(size: 14))
                        }
                        .background(Color("comment"))
                        .cornerRadius(15)
                        HStack {
                            Button(action: {
                                viewModel.replyTo = comment
                            }, label: {
                                Text("reply".localized)
                                    .bold()
                                    .font(Font.system(size: 14))
                            })
                            Text(comment.timeText)
                                .font(Font.system(size: 14))
                                .foregroundColor(Color.gray)
                        }
                    }
                    
                }
                .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                ForEach(comment.children ?? []) { child in
                    HStack(alignment: .top) {
                        URLImageView(url: Config.baseURL + (child.avatar ?? ""))
                            .clipShape(Circle())
                            .frame(width: 30, height: 30)
                            .padding(.all, 5)
                            .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(child.commentBy ?? "")
                                    .bold()
                                    .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                    .font(Font.system(size: 14))
                                Text(child.commentDetail ?? "")
                                    .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                                    .font(Font.system(size: 14))
                            }
                            .background(Color("comment"))
                            .cornerRadius(15)
                            HStack {
                                Text(child.timeText)
                                    .font(Font.system(size: 14))
                                    .foregroundColor(Color.gray)
                            }
                        }
                        
                    }
                    .padding(EdgeInsets.init(top: 0, leading: 70, bottom: 0, trailing: 20))
                    
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var reactionView: some View {
        VStack {
            HStack {
                if viewModel.isLoadingReact {
                    ActivityRep()
                } else {
                    if viewModel.currentReaction != .none {
                        Image.init(viewModel.currentReaction.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    Text(viewModel.reactModel.allReactionText)
                }
                Spacer()
                
                if let commentCount = viewModel.listComment.result?.count {
                    Text(commentCount.string + " " + "count_comment".localized)
                        .font(Font.system(size: 12))
                }
            }
            Divider()
            HStack {
                if viewModel.isShowReactionBar {
                    ReactionCommentView.init(isShowReactionBar: $viewModel.isShowReactionBar, selectedReaction: $viewModel.currentReaction, action: {
                        self.viewModel.sendReaction()
                    })
                } else {
                    if viewModel.isLoadingReact {
                        ActivityRep()
                    } else {
                        Button.init {
                            viewModel.isShowReactionBar = true
                        } label: {
                            if viewModel.currentReaction == .none {
                                Image(systemName: "hand.thumbsup")
                            } else {
                                Image(viewModel.currentReaction.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                            }
                            Text(viewModel.reactModel.myReactionText)
                                .font(Font.system(size: 12))
                                .foregroundColor(viewModel.currentReaction.color)
                        }
                    }
                }
                Spacer()
                Image(systemName: "bubble.left")
                Text("comment".localized)
                    .font(Font.system(size: 12))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
    }
}

struct SurveyDetailViewModel_Previews: PreviewProvider {
    static var previews: some View {
        SurveyDetailView(detailModel: SurveyResultModel.init(id: 1, surveyName: "", deadlineDate: 10000))
    }
}

