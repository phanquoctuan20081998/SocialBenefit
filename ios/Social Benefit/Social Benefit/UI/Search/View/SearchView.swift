//
//  SearchView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/10/2021.
//

import SwiftUI


struct SearchView: View {
    
    @EnvironmentObject var homeScreen: HomeScreenViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 15) {
                    SearchBarView(searchText: $searchViewModel.searchText, isSearching: $searchViewModel.isSearching, placeHolder: "your_searching_screen".localized, width: ScreenInfor().screenWidth * 0.8, height: 50, fontSize: 15, isShowCancelButton: false)
                    
                    Button {
                        homeScreen.isPresentedTabBar = true
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("close".localized)
                    }
                }
                
                ScrollView {
                    VStack {
                        let filteredData = searchViewModel.allSearchData.filter({searchViewModel.searchText.isEmpty ? true : ($0.title.localized.localizedStandardContains(searchViewModel.searchText))})
                        
                        ForEach(filteredData.indices, id: \.self) { i in
                            NavigationLink(destination: NavigationPageView(selection: filteredData[i].id).navigationBarHidden(true)) {
                                SearchCardView(icon: filteredData[i].icon, color: filteredData[i].color, title: filteredData[i].title)
                                    .foregroundColor(.black)
                            }
                        }
                    }.edgesIgnoringSafeArea(.all)
                        .frame(width: ScreenInfor().screenWidth)
                }
            }
            .onAppear {
                homeScreen.isPresentedTabBar = false
            }.navigationBarHidden(true)
        }
    }
}

struct NavigationPageView: View {
    
    @EnvironmentObject var homeScreen: HomeScreenViewModel
    var selection: Int
    
    var body: some View {
        switch selection {
        case 0:
            Text("0")
        case 1:
            UserInformationView(isPresentedTabBar: $homeScreen.isPresentedTabBar).navigationBarHidden(true)
        case 2:
            Text("2")
        case 3:
            HomeScreenView().navigationBarHidden(true)
        case 4:
            InternalNewsView(isPresentedTabBar: $homeScreen.isPresentedTabBar).navigationBarHidden(true)
        case 5:
            ListOfBenefitsView().navigationBarHidden(true)
        case 6:
            ListOfMerchantView()
                .navigationBarHidden(true)
                .onAppear {
                    homeScreen.selectedTab = "tag"
                    homeScreen.isPresentedTabBar = true
                }
        case 7:
            MyVoucherView().navigationBarHidden(true)
        case 8:
            Text("8")
        case 9:
            Text("9")
        default:
            Text("10")
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        //        SearchView()
        HomeScreenView()
    }
}
