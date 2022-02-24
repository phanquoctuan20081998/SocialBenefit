//
//  ListSurveyView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 25/11/2021.
//

import SwiftUI

struct ListSurveyView: View {
    
    @State private var tabSelection = 0
    @State private var isSearching = false
//    @State private var isMoveToSurveyDetail = false

    @StateObject private var viewModel = ListSurveyViewModel()
    
    var body: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 50)
            
            SearchBarView(searchText: $viewModel.keyword, isSearching: $isSearching, placeHolder: "search_for_survey".localized, width: ScreenInfor().screenWidth * 0.9, height: 30, fontSize: 13, isShowCancelButton: false)
                .font(.system(size: 13))
            
            Picker("", selection: $tabSelection.onChange(segmentOnChange(_:))) {
                Text("on_going".localized).tag(0)
                Text("finished".localized).tag(1)
            }
            .pickerStyle(.segmented)
            .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
            if viewModel.isLoading {
                LoadingPageView()
            } else {
                List(viewModel.listSurvey.result ?? []) { item in
                    NavigationLink.init(destination: SurveyDetailView(contentId: item.id)) {
                        HStack {
                            HStack(alignment: .top, spacing: 10) {
                                Image("survey_0909")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .scaledToFit()
                                VStack(alignment: .leading, spacing: 10) {
                                    if viewModel.tabSelection == 1 {
                                        Text(item.deadline_edText)
                                            .bold()
                                            .font(.system(size: 14))
                                    } else {
                                        Text(item.deadlineText)
                                            .bold()
                                            .font(.system(size: 14))
                                    }
                                    Text(item.surveyNameText)
                                        .font(.system(size: 14))
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        .background(BackgroundViewWithoutNotiAndSearch(isActive: Binding.constant(false), title: "surveys".localized, isHaveLogo: true))
        .onAppear() {
//            viewModel.firstRequest()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .errorPopup($viewModel.error)
    }
    
    func segmentOnChange(_ tag: Int) {
        Utils.dismissKeyboard()
        viewModel.tabSelection = tag
    }
}

struct ListSurveyView_Previews: PreviewProvider {
    static var previews: some View {
        ListSurveyView()
    }
}
