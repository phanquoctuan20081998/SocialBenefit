//
//  SearchView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/10/2021.
//

import SwiftUI

struct SearchContentView: View {
    
    @EnvironmentObject var searchViewModel: SearchViewModel
    @EnvironmentObject var homeScreen: HomeScreenViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                let filteredData = searchViewModel.allSearchData.filter({searchViewModel.searchText.isEmpty ? true : ($0.title.localized.localizedStandardContains(searchViewModel.searchText))})
                
                ForEach(filteredData.indices, id: \.self) { i in
                    NavigationLink(destination: getDestinationView(selection: i)) {
                        SearchCardView(icon: filteredData[i].icon, color: filteredData[i].color, title: filteredData[i].title)
                            .foregroundColor(.black)
                    }
                    
                }.edgesIgnoringSafeArea(.all)
                    .frame(width: ScreenInfor().screenWidth)
            }
        }
    }
    
    func getDestinationView(selection: Int) -> AnyView {
        
        switch selection {
        case 0:
            return AnyView(Text("0"))
        case 1:
            return AnyView(UserInformationView().navigationBarHidden(true))
        case 2:
            return AnyView(Text("2"))
        case 3:
            return AnyView(HomeScreenView(selectedTab: "house").navigationBarHidden(true))
        case 4:
            return AnyView(InternalNewsView(isPresentedTabBar: $homeScreen.isPresentedTabBar).navigationBarHidden(true))
        case 5:
            return AnyView(ListOfBenefitsView().navigationBarHidden(true))
        case 6:
            return AnyView(ListOfMerchantNavigation().navigationBarHidden(true))
        case 7:
            return AnyView(MyVoucherView().navigationBarHidden(true))
        case 8:
            return AnyView(Text("8"))
        case 9:
            return AnyView(Text("9"))
        default:
            return AnyView(Text("10"))
        }
        
    }
}

struct ListOfMerchantNavigation: View {
    @EnvironmentObject var homeScreen: HomeScreenViewModel
    
    var body: some View {
        HomeScreenView(selectedTab: "tag")
            .onAppear {
                DispatchQueue.main.async {
                    homeScreen.selectedTab = "tag"
                    homeScreen.isPresentedSearchView = true
                }
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
            UserInformationView().navigationBarHidden(true)
        case 2:
            Text("2")
        case 3:
            HomeScreenView(selectedTab: "house").navigationBarHidden(true)
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
        HomeScreenView(selectedTab: "house")
    }
}
