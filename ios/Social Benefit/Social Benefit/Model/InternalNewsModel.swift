//
//  InternalNewsModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/08/2021.
//

import Foundation

struct InternalNewsData: Identifiable, Hashable {
    var id: Int = 0
    
    var contentId: Int = 0
    var title: String = ""
    var shortBody: String = ""
    var cover: String = ""
    var newsCategory: Int = 0
}

//var internalNews = [InternalNewsData]()
//
//func updateInternalNews(data: [InternalNewsData]) {
//    internalNews = data
//}
