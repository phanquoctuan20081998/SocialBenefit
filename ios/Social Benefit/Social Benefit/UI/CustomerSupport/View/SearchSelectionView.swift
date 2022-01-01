//
//  SearchSelectionView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/10/2021.
//

import SwiftUI

struct SearchSelectionView: View {
    @State var isPresent = true
    @State var searchText = ""
    @State var isSearching = false
    
    @ObservedObject var searchViewModel = SearchViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var selectedTab: String
    
    var body: some View {
        SearchView(isPresent: $isPresent, searchText: $searchText, isSearching: $isSearching, contentView: AnyView(contentView))
    }
    
    var contentView: some View {
        
        ScrollView {
            VStack {
                let filteredData = searchViewModel.allSearchData.filter({searchViewModel.searchText.isEmpty ? true : ($0.title.localized.localizedStandardContains(searchViewModel.searchText))})
                
                ForEach(filteredData.indices, id: \.self) { i in
                    if filteredData[i].functionId.isEmpty || isDisplayFunction(filteredData[i].functionId) {
                        SearchCardView(icon: filteredData[i].icon, color: filteredData[i].color, title: filteredData[i].title)
                            .onTapGesture {
                                selectedTab = filteredData[i].title.localized
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
            }.edgesIgnoringSafeArea(.all)
                .frame(width: ScreenInfor().screenWidth)
        }.navigationBarHidden(true)
    }
}

struct SearchSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}
