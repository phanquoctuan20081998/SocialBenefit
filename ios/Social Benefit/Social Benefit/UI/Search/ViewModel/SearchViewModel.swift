//
//  SearchViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/10/2021.
//

import Foundation

class SearchViewModel: ObservableObject, Identifiable {
    @Published var allSearchData = [SearchBarData]()
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published var selection: Int? = nil
    
    init() {
        for i in Constants.SEARCH_TAB.indices {
            allSearchData.append(SearchBarData(id: i, icon: Constants.SEARCH_ICON[i], title: Constants.SEARCH_TAB[i], color: Constants.SEARCH_ICON_COLOR[i]))
        }
    }
}
