//
//  InternalNewsModelView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/09/2021.
//

import Foundation

class InternalNewsViewModel: ObservableObject {
    
    @Published var allInternalNews: [InternalNewsData] = []
    @Published var trainingInternalNews: [InternalNewsData] = []
    @Published var announcementInternalNews: [InternalNewsData] = []
    
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
    
    private let internalNewsService = InternalNewsService()
    
    init() {
        loadData()
    }
    
    func loadData() {
        
        var announcementInternalNews = [InternalNewsData]()
        var trainingInternalNews = [InternalNewsData]()
        
        self.isLoading = true
        
        internalNewsService.getAPI(fromIndex: 0, searchText: "", category: 0) { data in
            for item in data {
                if item.newsCategory == 1 {
                    announcementInternalNews.append(item)
                } else if item.newsCategory == 2 {
                    trainingInternalNews.append(item)
                }
            }
            
            DispatchQueue.main.async {
                self.allInternalNews = data
                self.trainingInternalNews = trainingInternalNews
                self.announcementInternalNews = announcementInternalNews
                
                if data.count < 6 {
                    self.allInternalNewsBanner = data
                } else {
                    self.allInternalNewsBanner = Array(data[0..<5])
                }
                
                
                self.isLoading = false
                self.isRefreshing = false
            }
        }
    }
    
    func refresh() {
        self.loadData()
    }
}









let allInternalNewsDebug = [InternalNewsData(id: 1, contentId: 1, title: "Test1", shortBody: "twgavsv", body: "jdsbcsbdc", cover: "https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif", newsCategory: 0),
                            InternalNewsData(id: 0, contentId: 0, title: "bchdsbchjsbchj", shortBody: "dsfbsdcbsdbc", body: "dsbcjhdsbchjsbdchj", cover: "https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif", newsCategory: 0),
                            InternalNewsData(id: 0, contentId: 0, title: "abcbhbc", shortBody: "ewfnrjn", body: "dcnnkjb", cover: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic", newsCategory: 0)]

