//
//  InternalNewsModelView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/09/2021.
//

import Foundation
import Combine

class InternalNewsViewModel: ObservableObject {
    
    @Published var allInternalNews: [InternalNewsData] = []
    @Published var fromIndex = 0
    @Published var searchPattern = ""
    @Published var category = InternalNewsSelectedTab
    
    // For show image at home screen
    @Published var allInternalNewsBanner: [InternalNewsData] = []
    
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let internalNewsService = InternalNewsService()
    
    init() {
        addSubscribers()
        loadData(fromIndex: 0, searchPattern: "", category: InternalNewsSelectedTab)
    }
    
    func addSubscribers() {
        $searchPattern
            .sink(receiveValue: loadSearchData(searchPattern:))
            .store(in: &cancellables)
        
        $category
            .sink(receiveValue: loadCategory(category:))
            .store(in: &cancellables)
    }
    
    func loadSearchData(searchPattern: String) {
        loadData(fromIndex: 0, searchPattern: searchPattern, category: category)
    }
    
    func loadCategory(category: Int) {
        loadData(fromIndex: 0, searchPattern: searchPattern, category: category)
    }
    
    func loadData(fromIndex: Int, searchPattern: String, category: Int) {
        
        self.isLoading = true
        
        internalNewsService.getAPI(fromIndex: fromIndex, searchText: searchPattern, category: category, pageSize: Constants.MAX_NUM_API_LOAD) { data in
  
            DispatchQueue.main.async {
                self.allInternalNews = data
                
                if category == Constants.InternalNewsType.ALL {
                    if data.count < 6 {
                        self.allInternalNewsBanner = data
                    } else {
                        self.allInternalNewsBanner = Array(data[0..<5])
                    }
                }
                
                self.isLoading = false
                self.isRefreshing = false
            }
        }
    }
    
    
    func refresh() {
        DispatchQueue.main.async {
            self.fromIndex = 0
            self.loadData(fromIndex: 0, searchPattern: self.searchPattern, category: self.category)
        }
    }
    
    func loadMoreData() {
        
        internalNewsService.getAPI(fromIndex: fromIndex, searchText: searchPattern, category: category, pageSize: Constants.MAX_NUM_API_LOAD) { data in
  
            DispatchQueue.main.async {
                for item in data {
                    self.allInternalNews.append(item)
                }
            }
        }
    }
    
    func reset() {
        self.fromIndex = 0
        self.searchPattern = ""
        self.category = 0
        self.allInternalNews = []
        
        InternalNewsSelectedTab = 0
    }
    
    func resetLoading() {
        self.isLoading = false
        self.isRefreshing = false
    }
}









let allInternalNewsDebug = [InternalNewsData(id: 1, contentId: 1, title: "Test1", shortBody: "twgavsv", body: "jdsbcsbdc", cover: "https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif", newsCategory: 0),
                            InternalNewsData(id: 0, contentId: 0, title: "bchdsbchjsbchj", shortBody: "dsfbsdcbsdbc", body: "dsbcjhdsbchjsbdchj", cover: "https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif", newsCategory: 0),
                            InternalNewsData(id: 0, contentId: 0, title: "abcbhbc", shortBody: "ewfnrjn", body: "dcnnkjb", cover: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic", newsCategory: 0)]
