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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var internalNewsViewModel: InternalNewsViewModel
    @ObservedObject var commentViewModel = CommentViewModel(contentId: 0)
    
    @Binding var isPresentedTabBar: Bool
    
    @State private var selectedTabIndex = 0
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var selectedInternalNew = InternalNewsData()
    @State var isActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                if selectedTabIndex == 0 {
                    AllTabView
                } else if selectedTabIndex == 1 {
                    TrainingTabView
                } else {
                    AnnoucementTabView
                }
            }
            .padding(.top, 160)
            .navigationBarHidden(true)
        }
        .overlay(InternalNewsUpperView, alignment: .top)
        .padding(.top, 0)
        .background(
            NavigationLink(
                destination: InternalNewsDetailView(internalNewData: selectedInternalNew).navigationBarHidden(true),
                isActive: $isActive,
                label: { EmptyView() })
        )
    }
}

extension InternalNewsView {
    
    private var InternalNewsUpperView: some View {
        VStack {
            Spacer().frame(height: 50)
            SearchBarView(searchText: $searchText, isSearching: $isSearching, placeHolder: "search_news".localized, width: ScreenInfor().screenWidth * 0.9, height: 30, fontSize: 13, isShowCancelButton: true)
            
            SlidingTabView(selection: self.$selectedTabIndex, tabs: ["all".localized, "training".localized, "annoucement".localized])
        }
        .background(Image("pic_background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea([.top])
                        .frame(width: ScreenInfor().screenWidth)
                        .overlay(
                            HStack {
                                HStack {
                                    Button(action: {
                                        //Do something
                                        self.presentationMode.wrappedValue.dismiss()
                                        self.isPresentedTabBar.toggle()
                                    }, label: {
                                        Image(systemName: "arrow.backward")
                                            .font(.headline)
                                            .foregroundColor(.blue)
                                            .padding(.leading, 20)
                                    }).padding(5)
                                    
                                    Text("internal_news".localized)
                                        .font(.system(size: 15))
                                        .foregroundColor(.blue)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                }
                                
                                URLImageView(url: userInfor.companyLogo)
                                    .frame(width: 30, height: 30)
                                    .padding(.all, 15)
                            }.padding(.top, 40)
                            , alignment: .top)
                    
                        .edgesIgnoringSafeArea(.all)
        )
    }
    
    private var AllTabView: some View {
        ZStack {
            if internalNewsViewModel.isLoading && !internalNewsViewModel.isRefreshing {
                LoadingPageView()
            } else {
                RefreshableScrollView(height: 70, refreshing: self.$internalNewsViewModel.isRefreshing) {
                    VStack (alignment: .leading, spacing: 10) {
                        
                        let filteredData = internalNewsViewModel.allInternalNews.filter({searchText.isEmpty ? true : ($0.title.localizedStandardContains(searchText) || $0.shortBody.localizedStandardContains(searchText))})
                        
                        ForEach(filteredData, id: \.self) { item in
                            InternalNewsCardView(isActive: $isActive, selectedInternalNew: $selectedInternalNew, internalNewsData: item)
                        }
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
                        
                        let filteredData = internalNewsViewModel.trainingInternalNews.filter({searchText.isEmpty ? true : ($0.title.contains(searchText) || $0.shortBody.contains(searchText))})
                        
                        ForEach(filteredData, id: \.self) { item in
                            InternalNewsCardView(isActive: $isActive, selectedInternalNew: $selectedInternalNew, internalNewsData: item)
                        }
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
                        
                        let filteredData = internalNewsViewModel.announcementInternalNews.filter({searchText.isEmpty ? true : ($0.title.contains(searchText) || $0.shortBody.contains(searchText))})
                        
                        ForEach(filteredData, id: \.self) { item in
                            InternalNewsCardView(isActive: $isActive, selectedInternalNew: $selectedInternalNew, internalNewsData: item)
                        }
                    }
                }
            }
        }
    }
}


struct SlidingTabView_Previews : PreviewProvider {
    static var previews: some View {
        InternalNewsView(isPresentedTabBar: .constant(false))
            .environmentObject(InternalNewsViewModel())
    }
}
