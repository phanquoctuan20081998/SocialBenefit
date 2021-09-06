//
//  InternalNewsDetailViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/09/2021.
//

import Foundation

struct ParentCommentData: Identifiable {
    let id = UUID()
    
    var data: CommentData
    var childIndex: Int
}

class CommentViewModel: ObservableObject, Identifiable {
    
    @Published var parentComment = [ParentCommentData]()
    @Published var childComment = [[CommentData]]()
    @Published var allComment = [CommentData]()
    
    @Published var index: Int
    @Published var numOfComment: Int = 0
    
    private let commentService: CommentService
    
    init(index: Int) {
        self.index = index
        self.commentService = CommentService(index: index)
        initComment()
    }
    
    func initComment() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.allComment = self.commentService.allComment
            self.numOfComment = self.commentService.allComment.count
            self.separateChildAndParent()
        }
    }
    
    func separateChildAndParent() {
        
        DispatchQueue.main.async {
            for item in self.allComment {
                if item.parentId == -1 {
                    let tempParent = ParentCommentData(data: item, childIndex: -1)
                    self.parentComment.append(tempParent)
                } else {
                    let sameParentIndex = self.findSameParent(Array: self.childComment, child: item)
                    
                    if sameParentIndex == -1 {
                        self.childComment.append([item])
                    } else {
                        self.childComment[sameParentIndex].append(item)
                    }
                }
            }
            
            if self.numOfComment != 0 {
                self.assignChildToParent()
            }
        }
    }
    
    func findSameParent(Array: [[CommentData]], child: CommentData) -> Int {
        for i in 0..<Array.count {
            if !Array[i].isEmpty {
                if (Array[i][0].parentId == child.parentId) {
                    return i
                }
            }
        }
        return -1
    }
    
    func assignChildToParent() {
        for i in 0..<self.childComment.count {
            for j in 0..<self.parentComment.count {
                if self.parentComment[j].data.id == self.childComment[i][0].parentId {
                    self.parentComment[j].childIndex = i
                }
            }
        }
    }
    
    func addComment(contentId: Int, parentId: Int, content: String) {
        
        print(contentId)
        print(parentId)
        print(content)
        
        let addCommentService = AddCommentService()
        addCommentService.getAPI(contentId: contentId, parentId: parentId, content: content)
    }
}
