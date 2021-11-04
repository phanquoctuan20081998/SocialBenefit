//
//  InternalNewsView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 12/08/2021.
//

import SwiftUI
import SlidingTabView

// Main
struct InternalNewsView: View {
    
    @EnvironmentObject var internalNewsViewModel: InternalNewsViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @ObservedObject var commentViewModel = CommentViewModel(contentId: 0)
    
//    @Binding var isPresentedTabBar: Bool
    
    @State private var selectedTabIndex = 0
    @State private var isSearching = false
    @State private var selectedInternalNew = InternalNewsData()
    @State var isActive = false
    
    var body: some View {
        VStack {
            InternalNewsUpperView
            
            VStack {
                TabView
                
                if selectedTabIndex == 0 {
                    AllTabView
                } else if selectedTabIndex == 1 {
                    TrainingTabView
                } else {
                    AnnoucementTabView
                }
            }.background(Color.white)
        }
        .background(
            BackgroundViewWithoutNotiAndSearch(isActive: $homeScreenViewModel.isPresentedTabBar, title: "internal_news".localized, isHaveLogo: true)
        )
        .background(
            NavigationLink(
                destination: InternalNewsDetailView(internalNewData: selectedInternalNew).navigationBarHidden(true),
                isActive: $isActive,
                label: { EmptyView() })
        )
    }
}

extension InternalNewsView {
    
    private var TabView: some View {
        HStack(spacing: 0) {
            ForEach(Constants.INTERNALNEWS_TABHEADER.indices, id:\.self) { i in
                Text(Constants.INTERNALNEWS_TABHEADER[i].localized)
                    .font(.system(size: 15))
                    .bold()
                    .foregroundColor((selectedTabIndex == i) ? Color.blue : Color.gray)
                    .frame(width: ScreenInfor().screenWidth / CGFloat(Constants.INTERNALNEWS_TABHEADER.count), height: 30)
                    .background((selectedTabIndex == i) ? Color("nissho_light_blue") : Color.white)
                    .onTapGesture {
                        withAnimation {
                            selectedTabIndex = i
                            if i == 0 {
                                internalNewsViewModel.category = Constants.InternalNewsType.ALL
                            } else if i == 1 {
                                internalNewsViewModel.category = Constants.InternalNewsType.TRAINING
                            } else if i == 2 {
                                internalNewsViewModel.category = Constants.InternalNewsType.ANNOUCEMENT
                            }
                        }
                    }
            }
        }.frame(width: ScreenInfor().screenWidth)
            .background(Color.white)
    }
    
    private var InternalNewsUpperView: some View {
        VStack {
            Spacer().frame(height: ScreenInfor().screenHeight * 0.05 + 30)
            SearchBarView(searchText: $internalNewsViewModel.searchPattern, isSearching: $isSearching, placeHolder: "search_news".localized, width: ScreenInfor().screenWidth * 0.9, height: 30, fontSize: 13, isShowCancelButton: true)
            
//            SlidingTabView(selection: self.$selectedTabIndex, tabs: ["all".localized, "training".localized, "annoucement".localized])
        }
    }
    
    private var AllTabView: some View {
        ZStack {
            if internalNewsViewModel.isLoading && !internalNewsViewModel.isRefreshing {
                LoadingPageView()
            } else {
                RefreshableScrollView(height: 70, refreshing: self.$internalNewsViewModel.isRefreshing) {
                    VStack (alignment: .leading, spacing: 10) {

                        ForEach(internalNewsViewModel.allInternalNews, id: \.self) { item in
                            InternalNewsCardView(isActive: $isActive, selectedInternalNew: $selectedInternalNew, internalNewsData: item)
                        }

                        Spacer().frame(height: 50)
                    }
                }
            }
        }
    }
    
    private var TrainingTabView: some View {
        ZStack {
            if internalNewsViewModel.isLoading && !internalNewsViewModel.isRefreshing {
                LoadingPageView()
            } else {
                RefreshableScrollView(height: 70, refreshing: self.$internalNewsViewModel.isRefreshing) {
                    VStack (alignment: .leading, spacing: 10) {
                        
                        ForEach(internalNewsViewModel.trainingInternalNews, id: \.self) { item in
                            InternalNewsCardView(isActive: $isActive, selectedInternalNew: $selectedInternalNew, internalNewsData: item)
                        }
                        
                        Spacer().frame(height: 50)
                    }
                }
            }
        }
    }
    
    private var AnnoucementTabView: some View {
        ZStack {
            if internalNewsViewModel.isLoading && !internalNewsViewModel.isRefreshing {
                LoadingPageView()
            } else {
                RefreshableScrollView(height: 70, refreshing: self.$internalNewsViewModel.isRefreshing) {
                    VStack (alignment: .leading, spacing: 10) {
                    
                        ForEach(internalNewsViewModel.announcementInternalNews, id: \.self) { item in
                            InternalNewsCardView(isActive: $isActive, selectedInternalNew: $selectedInternalNew, internalNewsData: item)
                        }
                        
                        Spacer().frame(height: 50)
                    }
                }
            }
        }
    }
}


struct SlidingTabView_Previews : PreviewProvider {
    static var previews: some View {
        InternalNewsView()
            .environmentObject(InternalNewsViewModel())
    }
}
