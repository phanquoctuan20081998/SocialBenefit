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
    
    @State var isMoveToNextPage = false
    @State var selectedTab = -1
    
    var body: some View {
        
        let filteredData = searchViewModel.allSearchData.filter({searchViewModel.searchText.isEmpty ? true : ($0.title.localized.localizedStandardContains(searchViewModel.searchText))})
        
        ScrollView {
            VStack {
                ForEach(filteredData.indices, id: \.self) { i in
                    if filteredData[i].functionId.isEmpty || isDisplayFunction(filteredData[i].functionId) {
                        SearchCardView(icon: filteredData[i].icon, color: filteredData[i].color, title: filteredData[i].title)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.black)
                            .onTapGesture {
                                self.isMoveToNextPage.toggle()
                                self.selectedTab = i
                                countClick()
                            }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(
            ZStack {
                if selectedTab != -1 {
                    NavigationLink(destination: NavigationLazyView(getDestinationView(selection: filteredData[selectedTab].destination)),
                                   isActive: $isMoveToNextPage,
                                   label: { EmptyView() })
                }
            }
        )
        .onAppear {
            UIScrollView.appearance().bounces = true
        }
    }
    
    func getDestinationView(selection: Int) -> AnyView {
        
        switch selection {
        case 0:
            return AnyView(ListSurveyView())
        case 1:
            return AnyView(UserInformationView())
//        case 2:
//            return AnyView(Text("2"))
        case 3:
            return AnyView(HomeScreenView(selectedTab: "house"))
        case 4:
            return AnyView(InternalNewsView())
        case 5:
            return AnyView(ListOfBenefitsView())
        case 6:
            return AnyView(HomeScreenView(selectedTab: "tag"))
        case 7:
            return AnyView(MyVoucherView())
        case 8:
            return AnyView(RecognitionActionView())
        case 9:
            return AnyView(HomeScreenView(selectedTab: "star"))
        default:
            return AnyView(UsedPointHistoryView())
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        //        SearchView()
        HomeScreenView(selectedTab: "house")
    }
}
