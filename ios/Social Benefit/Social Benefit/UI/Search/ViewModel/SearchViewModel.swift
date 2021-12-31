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
        let backgroundSearch = Constants.BACKGROUND_SEARCH.sorted(by: { $0.tab.localized.lowercased() < $1.tab.localized.lowercased() })
        
        for i in backgroundSearch.indices {
            allSearchData.append(SearchBarData(id: i, icon: backgroundSearch[i].icon, title: backgroundSearch[i].tab, color: backgroundSearch[i].color, destination: backgroundSearch[i].destination, functionId: backgroundSearch[i].functionId))
        }
    }
}
