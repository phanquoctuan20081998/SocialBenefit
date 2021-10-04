//
//  SearchViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/10/2021.
//

import Foundation

class SearchViewModel: ObservableObject, Identifiable {
    @Published var allSearchData = [SearchBarData]()
    
    init() {
        for i in Constants.SEARCH_TAB.indices {
            allSearchData.append(SearchBarData(icon: Constants.SEARCH_ICON[i], title: Constants.SEARCH_TAB[i], color: Constants.SEARCH_ICON_COLOR[i]))
        }
    }
}
