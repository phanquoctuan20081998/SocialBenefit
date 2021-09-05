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
    
    private let internalNewsService = InternalNewsService()
    
    init() {
        addInternalNews()
    }
    
    func addInternalNews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for item in self.internalNewsService.allInternalNews {
                if item.newsCategory == 1 {
                    self.announcementInternalNews.append(item)
                }
                else if item.newsCategory == 2 {
                    self.trainingInternalNews.append(item)
                }
                self.allInternalNews.append(item)
            }
        }
    }
}
