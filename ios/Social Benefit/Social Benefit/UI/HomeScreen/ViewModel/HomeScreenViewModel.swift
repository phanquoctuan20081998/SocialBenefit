//
//  HomeScreenViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import Foundation

class HomeScreenViewModel: ObservableObject, Identifiable {
    @Published var selectedTab = "house"
    @Published var isPresentedError = false
    @Published var isPresentedTabBar = true
    @Published var isPresentedSearchView = false
}
