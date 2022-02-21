//
//  CommentEnvironmentObject.swift
//  Social Benefit
//
//  Created by chu phuong dong on 27/01/2022.
//

import Foundation
import UIKit

class CommentEnvironmentObject: ObservableObject {
    
    private let listCommentService = ListCommentService()
    private let deleteCommentService = DeleteCommentSurveySerive()
    private let editCommentService = EditCommentSurveySerive()
    private let addCommentService = AddCommentSurveyService()
    
    private let commentDetailService = CommentDetailService()
    
    private let reactSerivce = AddReactSurveyService()
    
    @Published var listComment = ListCommentModel()
    
    @Published var replyTo: CommentResultModel?
    
    @Published var commentSelected: CommentResultModel?
    
    @Published var commentEdited: CommentResultModel?
    
    @Published var commentDeleted: CommentResultModel?
    
    @Published var newComment = ""
    
    @Published var isLoading = false
    
    @Published var error: AppError = .none
    
    @Published var focusComment = false
    
    @Published var commentString = ""
    
    @Published var isSendingComment = false
    
    @Published var scrollToBottom = false
    
    @Published var commentReacted: CommentResultModel?
    
    @Published var commentPosition: CGRect?
    
    @Published var commentId = 0
    
    func requestListComment(id: Int, contentType: Int, completion: (() -> Void)? = nil) {
        listCommentService.request(contentId: id, contentType: contentType) { response in
            switch response {
            case .success(let value):
                self.listComment = value
                completion?()
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func didLongTapCommnet(_ comment: CommentResultModel) {
        if comment.commentByEmployeeId?.string == userInfor.employeeId {
            Utils.dismissKeyboard()
            commentSelected = comment
        }
    }
    
    func deleteComment() {
        if let comment = commentDeleted {
            isLoading = true
            deleteCommentService.request(comment: comment) { response in
                switch response {
                case .success(_):
                    self.listComment.deleteComment(comment: comment)
                    self.commentDeleted = nil
                case .failure(let error):
                    self.error = error
                }
                self.isLoading = false
            }
        }
    }
    
    func updateComment() {
        if var comment = commentEdited {
            comment.commentDetail = newComment
            isLoading = true
            editCommentService.request(comment: comment) { response in
                switch response {
                case .success(_):
                    self.listComment.updateComment(comment: comment)
                    self.commentEdited = nil
                case .failure(let error):
                    self.error = error
                }
                self.isLoading = false
            }
        }
    }
    
    func sendComment(contentId: Int, contentType: Int) {
        isSendingComment = true
        let shouldScroll = self.replyTo == nil
        addCommentService.request(replyTo: replyTo, contentId: contentId, contentType: contentType, content: commentString) { response in
            switch response {
            case.success(_ ):
                self.requestListComment(id: contentId, contentType: contentType) {
                    if shouldScroll {
                        DispatchQueue.main.async {
                            self.scrollToBottom = true
                        }
                    }
                }
                self.commentString = ""
                self.replyTo = nil
            case .failure(let error):
                print(error)
            }
            self.isSendingComment = false
        }
    }
    
    func addReactForComment(_ type: ReactionType) {
        let id = commentReacted?.id
        self.listComment.updateCommentReact(id: id, reactType: type)
        reactSerivce.request(contentId: id, contentType: Constants.CommentContentType.COMMENT_TYPE_COMMENT, reactType: type) { response in
            switch response {
            case .success(_):
                self.getCommentDetail(id: id)
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func getCommentDetail(id: Int?) {
        commentDetailService.request(contentId: id) { response in
            switch response {
            case .success(let value):
                if let comment = value.result {
                    self.listComment.updateCommentDetail(comment)
                }
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func clearCommentReacted() {
        self.commentReacted = nil
        self.commentPosition = nil
    }
}
