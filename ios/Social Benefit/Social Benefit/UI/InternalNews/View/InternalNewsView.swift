//
//  InternalNewsView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 12/08/2021.
//

import SwiftUI

// Global Variable to control selected tab
public var InternalNewsSelectedTab: Int = 0

// Main
struct InternalNewsView: View {
    
    @EnvironmentObject var internalNewsViewModel: InternalNewsViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @ObservedObject var commentViewModel = CommentViewModel(contentId: 0)
    
    @State private var selectedTabIndex = InternalNewsSelectedTab
    @State private var isSearching = false
    @State private var selectedInternalNew = InternalNewsData()
    @State var isActive = false
    
    //Infinite ScrollView controller
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        VStack {
            InternalNewsUpperView
            
            VStack {
                TabView
                TabContentView
            }
            .background(Color("nissho_light_blue"))
            .edgesIgnoringSafeArea(.all)
        }
        .background(
            BackgroundViewWithoutNotiAndSearch(isActive: $homeScreenViewModel.isPresentedTabBar, title: "internal_news".localized, isHaveLogo: true, backButtonTapped: internalNewsViewModel.reset)
        )
        .background(
            NavigationLink(
                destination: NavigationLazyView(InternalNewsDetailView(internalNewData: selectedInternalNew)),
                isActive: $isActive,
                label: { EmptyView() })
        )
        .navigationBarHidden(true)
    }
}

extension InternalNewsView {
     
    private var TabView: some View {
        HStack(spacing: 0) {
            ForEach(Constants.INTERNALNEWS_TABHEADER.indices, id:\.self) { i in
                Text(Constants.INTERNALNEWS_TABHEADER[i].localized)
                    .font(.system(size: 13))
                    .bold()
                    .foregroundColor((selectedTabIndex == i) ? Color.blue : Color.gray)
                    .frame(width: ScreenInfor().screenWidth / CGFloat(Constants.INTERNALNEWS_TABHEADER.count), height: 40)
                    .multilineTextAlignment(.center)
                    .background((selectedTabIndex == i) ? Color("nissho_light_blue") : Color.white)
                    .onTapGesture {
                        withAnimation {
                            selectedTabIndex = i
                            InternalNewsSelectedTab = i
                            
                            if i == 0 {
                                internalNewsViewModel.category = Constants.InternalNewsType.ALL
                            } else if i == 1 {
                                internalNewsViewModel.category = Constants.InternalNewsType.TRAINING
                            } else if i == 2 {
                                internalNewsViewModel.category = Constants.InternalNewsType.ANNOUCEMENT
                            } else {
                                internalNewsViewModel.category = Constants.InternalNewsType.OTHER
                            }
                        }
                    }
            }
        }.frame(width: ScreenInfor().screenWidth)
            .background(Color.white)
    }
    
    private var InternalNewsUpperView: some View {
        VStack {
            Spacer().frame(height: ScreenInfor().screenHeight * 0.05 + 20)
            SearchBarView(searchText: $internalNewsViewModel.searchPattern, isSearching: $isSearching, placeHolder: "search_news".localized, width: ScreenInfor().screenWidth * 0.9, height: 30, fontSize: 13, isShowCancelButton: false)
        }
    }
    
    private var TabContentView: some View {
        ZStack {
            if internalNewsViewModel.isLoading && !internalNewsViewModel.isRefreshing {
                LoadingPageView()
            } else {
                RefreshableScrollView(height: 70, refreshing: self.$internalNewsViewModel.isRefreshing) {
                    VStack (alignment: .leading, spacing: 10) {
                        Spacer().frame(height: 10)
                        ForEach(internalNewsViewModel.allInternalNews, id: \.self) { item in
                            InternalNewsCardView(isActive: $isActive, selectedInternalNew: $selectedInternalNew, internalNewsData: item)
                        }
                        
                        //Infinite Scroll View
                        
                        if (internalNewsViewModel.fromIndex == internalNewsViewModel.allInternalNews.count && self.isShowProgressView) {
                            
                            ActivityIndicator(isAnimating: true)
                                .frame(width: ScreenInfor().screenWidth, alignment: .center)
                                .onAppear {
                                    
                                    // Because the maximum length of the result returned from the API is 10...
                                    // So if length % 10 != 0 will be the last queue...
                                    // We only send request if it have more data to load...
                                    if self.internalNewsViewModel.allInternalNews.count % Constants.MAX_NUM_API_LOAD == 0 {
                                        self.internalNewsViewModel.loadMoreData()
                                    }
                                    
                                    // Otherwise just delete the ProgressView after 1 seconds...
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.isShowProgressView = false
                                    }
                                    
                                }
                            
                        } else {
                            GeometryReader { reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let height = ScreenInfor().screenHeight / 1.3
                                
                                if !self.internalNewsViewModel.allInternalNews.isEmpty && minY < height && internalNewsViewModel.allInternalNews.count >= Constants.MAX_NUM_API_LOAD  {
                                    
                                    DispatchQueue.main.async {
                                        self.internalNewsViewModel.fromIndex = self.internalNewsViewModel.allInternalNews.count
                                        self.isShowProgressView = true
                                    }
                                }
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
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
            .environmentObject(HomeScreenViewModel())
    }
}

