//
//  InternalNewsModelView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/09/2021.
//

import Foundation

class InternalNewsViewModel: ObservableObject {
    
    @Published var allInternalNews: [InternalNewsData] = allInternalNewsDebug
    @Published var trainingInternalNews: [InternalNewsData] = []
    @Published var announcementInternalNews: [InternalNewsData] = []
    
    private let internalNewsService = InternalNewsService()
    
    init() {
        addInternalNews()
    }
    
    func addInternalNews() {
        
        internalNewsService.getAPI { data in
            for item in data {
                if item.newsCategory == 1 {
                    self.announcementInternalNews.append(item)
                } else if item.newsCategory == 2 {
                    self.trainingInternalNews.append(item)
                }
                
                self.allInternalNews.append(item)
            }
        }
    }
}

let allInternalNewsDebug = [InternalNewsData(id: 1, contentId: 1, title: "Test1", shortBody: "twgavsv", body: "jdsbcsbdc", cover: "https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif", newsCategory: 0),
                            InternalNewsData(id: 0, contentId: 0, title: "bchdsbchjsbchj", shortBody: "dsfbsdcbsdbc", body: "dsbcjhdsbchjsbdchj", cover: "https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif", newsCategory: 0),
                            InternalNewsData(id: 0, contentId: 0, title: "abcbhbc", shortBody: "ewfnrjn", body: "dcnnkjb", cover: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic", newsCategory: 0)]

