//
//  RecognitionView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 18/11/2021.
//

import SwiftUI
import ScrollViewProxy

struct RecognitionView: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @ObservedObject var recognitionViewModel = RecognitionViewModel()
    
    @State private var proxy: AmzdScrollViewProxy? = nil
    @State var isTop3RankingClick = false
    
    @State var isRecognitionPostClick = false
    @State var selectedPost = RecognitionData()
    
    // Infinite ScrollView controller
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        VStack {
            Spacer().frame(height: ScreenInfor().screenHeight * 0.1)
            RefreshableScrollView(height: 70, refreshing: self.$recognitionViewModel.isRefreshing) {
                AmzdScrollViewReader { proxy in
                    VStack (spacing: 30) {
                        
                         RankingCardView()
                            .onTapGesture {
                                self.isTop3RankingClick = true
                                
                                // Click count
                                countClick()
                            }
                            .buttonStyle(NavigationLinkNoAffectButtonStyle())
                        
                        NavigationLink(destination: NavigationLazyView(RankingOfRecognitionView()
                                                                        .environmentObject(recognitionViewModel)
                                                                        .navigationBarHidden(true)
                                                                        .navigationBarBackButtonHidden(true))) {
                            MyRankView
                                .foregroundColor(.black)
                        }
                        
                        NewsFeedTabView
                        
                    }.onAppear { self.proxy = proxy }
                }
            }
        }
        .background(
            ZStack {
                NavigationLink(destination: NavigationLazyView(RankingOfRecognitionView()
                                .environmentObject(recognitionViewModel)
                                .navigationBarHidden(true)),
                               isActive: $isTop3RankingClick, label: { EmptyView() })
            }
        )
        .background(
            ZStack {
                if self.selectedPost.id != 0 {
                    NavigationLink(destination: NavigationLazyView(RecognitionPostView(companyData: selectedPost)),
                                   isActive: $isRecognitionPostClick,
                                   label: { EmptyView() })
                }
            }
        )
        .onAppear(perform: {
            homeScreenViewModel.isPresentedTabBar = true
        })
        .environmentObject(recognitionViewModel)
        .edgesIgnoringSafeArea(.all)
        .background(BackgroundViewWithNotiAndSearch())
    }
}

extension RecognitionView {
    
    var MyRankView: some View {
        VStack {
            Text("this_month_you_are_on_top %d".localizeWithFormat(arguments: recognitionViewModel.myRank))
            
            Text("detail_recognition_rank".localized)
                .foregroundColor(.blue)
        }
        .font(.system(size: 14))
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color("nissho_light_blue"), .white]), startPoint: .top, endPoint: .bottom))
                .frame(width: ScreenInfor().screenWidth * 0.92)
        )
    }
    
    var NewsFeedTabView: some View {
        VStack {
            
            // Top title view
            VStack(alignment: .leading, spacing: 0) {
                TopTitleView(title: "recognitions_news_feed".localized, topTitleTapped: topTitledTapped, isSeeAll: false)
                    .font(.system(size: 14, weight: .heavy))
                    .foregroundColor(.blue)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(Color.blue.opacity(0.2))
                    .padding(.horizontal, 20)
            }.padding(.horizontal, 20)
            
            VStack(spacing: 0) {
                
                // Tab header
                HStack(spacing: 0) {
                    ForEach(recognitionViewModel.header.indices, id: \.self) { index in
                        let isSelect = (index == recognitionViewModel.selectedTab)
                        Text(recognitionViewModel.header[index].localized)
                            .foregroundColor(isSelect ? .blue : .gray)
                            .font(.system(size: 14))
                            .frame(width: ScreenInfor().screenWidth / 2)
                            .padding(10)
                            .background(
                                Rectangle()
                                    .fill(isSelect ? Color("nissho_light_blue") : .white)
                            )
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    recognitionViewModel.selectedTab = index
                                }
                            }
                    }
                }
                
                Spacer().frame(height: 20)
                
                
                // Content
                if recognitionViewModel.isLoading && !recognitionViewModel.isRefreshing {
                    LoadingPageView()
                } else {
                    ForEach(recognitionViewModel.allRecognitionPost.indices, id: \.self) { index in
                        VStack {
                            
                            // Print date
                            let i = self.recognitionViewModel.isNewDate(index: index)
                            
                            if self.recognitionViewModel.selectedTab == Constants.RecognitionNewsFeedType.YOUR_HISTORY && i != -1 {
                                Text(getDateSinceToday(time: recognitionViewModel.sameDateGroup[i].date).localized)
                                    .bold()
                                    .font(.system(size: 14))
                                    .frame(width: ScreenInfor().screenWidth * 0.9, alignment: .leading)
                                    .padding(.vertical)
                            }
                            
                            RecognitionNewsCardView(companyData: recognitionViewModel.allRecognitionPost[index], index: index, proxy: $proxy, newsFeedType: recognitionViewModel.selectedTab, isHaveReactAndCommentButton: true)
                                .onTapGesture(perform: {
                                    self.isRecognitionPostClick = true
                                    self.selectedPost = recognitionViewModel.allRecognitionPost[index]
                                    
                                    // Click count
                                    countClick(contentId: recognitionViewModel.allRecognitionPost[index].getId(), contentType: Constants.ViewContent.TYPE_RECOGNITION)
                                })
                                .buttonStyle(NavigationLinkNoAffectButtonStyle())
                            
                            Spacer().frame(height: 20)
                            
                        }
                        .scrollId(index)
                        
                    }
                    
                    //Infinite Scroll View
                    
                    if (recognitionViewModel.fromIndex == recognitionViewModel.allRecognitionPost.count && isShowProgressView) {
                        
                        ActivityIndicator(isAnimating: true)
                            .onAppear {
                                
                                // Because the maximum length of the result returned from the API is 10...
                                // So if length % 10 != 0 will be the last queue...
                                // We only send request if it have more data to load...
                                if recognitionViewModel.allRecognitionPost.count % Constants.MAX_NUM_API_LOAD == 0 {
                                    self.recognitionViewModel.reloadData()
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
                            
                            if !recognitionViewModel.allRecognitionPost.isEmpty && minY < height && recognitionViewModel.allRecognitionPost.count >= Constants.MAX_NUM_API_LOAD  {
                                
                                DispatchQueue.main.async {
                                    recognitionViewModel.fromIndex = recognitionViewModel.allRecognitionPost.count
                                    self.isShowProgressView = true
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 20, height: 20)
                    }
                }
                
                Spacer().frame(height: 500)
            }
            .background(Color("nissho_light_blue"))
        }
    }
    
    func topTitledTapped() {
        
    }
}

struct RecognitionView_Previews: PreviewProvider {
    static var previews: some View {
        RecognitionView()
    }
}
