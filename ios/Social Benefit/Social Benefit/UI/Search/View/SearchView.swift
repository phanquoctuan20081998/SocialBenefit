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
    
    @State var searchText: String = ""
    @State var isSearching: Bool = false
    
    var body: some View {
        VStack {
            
            HStack(spacing: 15) {
                SearchBarView(searchText: $searchText, isSearching: $isSearching, placeHolder: "your_searching_screen".localized, width: ScreenInfor().screenWidth * 0.8, height: 50, fontSize: 15, isShowCancelButton: false)
                
                Button {
                    homeScreen.isPresentedTabBar = true
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("close".localized)
                }
            }
            
            ScrollView {
                VStack {
                    let filteredData = searchViewModel.allSearchData.filter({searchText.isEmpty ? true : ($0.title.localized.localizedStandardContains(searchText))})
                    
                    ForEach(filteredData.indices, id: \.self) { i in
                        SearchCardView(icon: filteredData[i].icon, color: filteredData[i].color, title: filteredData[i].title)
                    }
                }.edgesIgnoringSafeArea(.all)
                    .frame(width: ScreenInfor().screenWidth)
            }
        }.onAppear {
            homeScreen.isPresentedTabBar = false
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
