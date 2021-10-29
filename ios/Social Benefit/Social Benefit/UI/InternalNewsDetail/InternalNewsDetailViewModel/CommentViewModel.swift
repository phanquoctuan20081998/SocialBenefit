//
//  InternalNewsDetailViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/09/2021.
//

import Foundation
import Combine

struct ParentCommentData: Identifiable {
    let id = UUID()
    
    var data: CommentData
    var childIndex: Int
    
    init() {
        self.data = CommentData(id: 0, contentId: 0, parentId: 0, avatar: "", commentBy: "", commentDetail: "", commentTime: "")
        self.childIndex = 0
    }
    
    init(data: CommentData, childIndex: Int) {
        self.data = data
        self.childIndex = childIndex
    }
}

class CommentViewModel: ObservableObject, Identifiable {
    
    @Published var parentComment = [ParentCommentData]()
    @Published var childComment = [[CommentData]]()
    @Published var allComment = [CommentData]()
    
    @Published var contentId: Int
    @Published var numOfComment: Int = 0
    
    @Published var isReply: Bool = false
    @Published var parentId: Int = -1
    @Published var replyTo: String = ""
    @Published var moveToPosition: Int = 0
    
    @Published var commentText = ""
    
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    private let commentService = CommentService()
    private var cancellables = Set<AnyCancellable>()
    
    init(contentId: Int) {
        self.contentId = contentId
        initComment(contentId: contentId)
        addSubscribers()
    }
    
    func initComment(contentId: Int) {
        self.isLoading = true
        commentService.getAPI(contentId) { data in
            DispatchQueue.main.async {
                self.allComment = data
                self.numOfComment = data.count
                self.separateChildAndParent(allComment: data)
                
                self.isLoading = false
                self.isRefreshing = false
            }
        }
    }
    
    func refresh() {
        self.initComment(contentId: self.contentId)
    }
    
    func addSubscribers() {
        $commentText
            .sink(receiveValue: loadCommentText(commentText:))
            .store(in: &cancellables)
    }
    
    func loadCommentText(commentText: String) {
        if commentText.count > 250 {
            DispatchQueue.main.async {
                self.commentText = String(commentText.prefix(250))
            }
        }
    }
    
    func separateChildAndParent(allComment: [CommentData]) {
        
        var tempParentComment = [ParentCommentData]()
        var tempChildComment = [[CommentData]]()
        
        for item in allComment {
            if item.parentId == -1 {
                let tempParent = ParentCommentData(data: item, childIndex: -1)
                tempParentComment.append(tempParent)
            } else {
                let sameParentIndex = self.findSameParent(Array: tempChildComment, child: item)
                
                if sameParentIndex == -1 {
                    tempChildComment.append([item])
                } else {
                    tempChildComment[sameParentIndex].append(item)
                }
            }
        }
        
        self.parentComment = tempParentComment
        self.childComment = tempChildComment
        
        if self.numOfComment != 0 {
            self.assignChildToParent()
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
    
    func updateComment(newComment: CommentData) {
        if newComment.parentId == -1 {
            let parentData = ParentCommentData(data: newComment, childIndex: -1)
            self.parentComment.append(parentData)
        } else {
            for i in self.parentComment.indices {
                if self.parentComment[i].data.id == newComment.parentId {
                    let childId = self.parentComment[i].childIndex
                    
                    //If parent hasn't had child yet
                    if childId == -1 {
                        self.childComment.append([newComment])
                        self.parentComment[i].childIndex = self.childComment.count - 1
                    } else {
                        self.childComment[childId].append(newComment)
                    }
                }
            }
        }
    }
}
