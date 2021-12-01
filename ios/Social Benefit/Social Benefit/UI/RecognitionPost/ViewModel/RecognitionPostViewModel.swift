//
//  RecognitionPostViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/11/2021.
//

import Foundation
import Combine

class RecognitionPostViewModel: ObservableObject, Identifiable {
    
    // For post content controller
    @Published var recognitionDetailData = RecognitionDetailData.sampleData
    @Published var recognitionData = RecognitionData.sampleData[0]
    
    // For comment controller
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
    
    // For loading, refresh controller
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    private var recognitionService = RecognitionService()
    private let commentService = CommentService()
    private var cancellables = Set<AnyCancellable>()
    private let dateFomatter = DateFormatter()
    
    init(id: Int) {
        self.contentId = id
        
        // Load data
        loadRecognitionDetailData(id: id)
        loadRecognitionData(id: id)
        loadComment(id: id)
        
        // Initial
        addSubscribers()
        dateFomatter.dateFormat = "hh:mm dd/MM/yyyy"
    }
    
    func addSubscribers() {
        $commentText
            .sink(receiveValue: loadCommentText(commentText:))
            .store(in: &cancellables)
    }
    
    func loadRecognitionDetailData(id: Int) {
        self.isLoading = true
        
        recognitionService.getPostDetail(id: id) { [weak self] data in
            DispatchQueue.main.async {
                self?.recognitionDetailData = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func loadRecognitionData(id: Int) {
        self.isLoading = true
        
        recognitionService.getPostReaction(id: id) { [weak self] data in
            DispatchQueue.main.async {
                self?.recognitionData = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func loadComment(id: Int) {
        self.isLoading = true
        commentService.getAPI(contentId: id, contentType: Constants.CommentContentType.COMMENT_TYPE_RECOGNITION) { data in
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
        loadRecognitionDetailData(id: self.contentId)
        loadRecognitionData(id: self.contentId)
        loadComment(id: self.contentId)
    }
    
    func reloadData() {
        
    }
    
    func getDate(date: Date) -> String {
        dateFomatter.string(from: date)
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
