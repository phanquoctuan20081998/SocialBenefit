//
//  CommentModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 31/08/2021.
//

import Foundation

struct CommentData: Identifiable, Hashable {
    var id: Int
    
    var contentId: Int
    var parentId: Int?
    var avatar: String
    var commentBy: String
    var commentDetail: String
    var commentTime: String
}


