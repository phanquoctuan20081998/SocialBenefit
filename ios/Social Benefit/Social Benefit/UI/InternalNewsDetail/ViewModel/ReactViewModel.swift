//
//  ReactViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 07/09/2021.
//

import Foundation
import SwiftUI
import Combine

class ReactViewModel: ObservableObject, Identifiable {
    
    @Published var allReact = [ReactData]()
    @Published var numOfReact: Int = 0
    @Published var reactCount = [0, 0, 0, 0, 0, 0, 0, 0]
    
    @Published var isReacted: Bool = false
    @Published var selectedReaction: Int = 6 // 6 is "" in reactions constant
    @Published var isShowReactionBar: Bool = false
    @Published var previousReaction: Int = 6 // index = 6 is defined as "" in reaction array
    
    @Published var isLoadingReact: Bool = false
    @Published var currentReaction = ReactionType.none
    @Published var reactModel = ReactSuveryModel() 
//    @Published var listComment = ListCommentModel()
    
    @Published var isShowReactionList = false
    
    private let reactService = ReactService()
    private let listReactService = ListReactService()
    private let addReactService = AddReactSurveyService()
//    private let listCommentService = ListCommentService()
    
    private var cancellables = Set<AnyCancellable>()
    
    // For Recognition..
    @Published var reactTop1: Int = 6
    @Published var reactTop2: Int = 6
    
    private var contentType = 0
    
    // INIT
    // Internal News...
    init(contentId: Int) {
        initComment(contentId: contentId)
        self.contentType = Constants.ReactContentType.INTERNAL_NEWS
        self.getListReact(id: contentId)
//        self.requestListComment(id: contentId)
    }
    
    // Recognition...
    init(myReact: Int, reactTop1: Int, reactTop2: Int) {
        if myReact != -1 {
            isReacted = true 
            selectedReaction = myReact
        }
        
        self.reactTop1 = reactTop1
        self.reactTop2 = reactTop2
        
        if self.reactTop1 == -1 {
            self.reactTop1 = 6
        }
        
        if self.reactTop2 == -1 {
            self.reactTop2 = 6
        }
        
        
        self.reactCount[self.reactTop1] += 1
        self.reactCount[self.reactTop2] += 1
        
        self.addSubscribers()
        
        self.contentType = Constants.ReactContentType.RECOGNIZE
    }
    
    func initComment(contentId: Int) {
        reactService.getAPI(contentId: contentId) { data in
            DispatchQueue.main.async {
                self.allReact = data
                
                for react in data {
                    switch react.reactType {
                    case Constants.ReactType.LIKE:
                        self.reactCount[0] += 1
                    case Constants.ReactType.LOVE:
                        self.reactCount[1] += 1
                    case Constants.ReactType.LAUGH:
                        self.reactCount[2] += 1
                    case Constants.ReactType.SAD:
                        self.reactCount[4] += 1
                    case Constants.ReactType.ANGRY:
                        self.reactCount[5] += 1
                    default:
                        // More react
                        print("This \(String(describing: react.reactType)) reaction hasn't developed yet!")
                    }
                }
                
                self.numOfReact = self.reactCount.reduce(0, +)
                
                self.getUserStatus()
                
            }
        }
    }
    
    func getListReact(id: Int?) {
        isLoadingReact = true
        listReactService.request(contentId: id, contentType: Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS) { response in
            switch response {
            case .success(let value):
                self.reactModel = value
                self.currentReaction = value.myRectionType
            case .failure(let error):
                print(error)
            }
            self.isLoadingReact = false
        }
    }
    
    func sendReaction(contentId: Int) {
        isLoadingReact = true
        addReactService.request(contentId: contentId,
                                contentType: Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS,
                                reactType: currentReaction) { response in
            switch response {
            case .success(let value):
                if value.status == 200 {
                    self.getListReact(id: contentId)
                } else {
                    self.isLoadingReact = false
                }
            case .failure(let error):
                print(error)
                self.isLoadingReact = false
            }
        }
    }
    
//    func requestListComment(id: Int) {
//        listCommentService.request(contentId: id, contentType: Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS) { response in
//            switch response {
//            case .success(let value):
//                self.listComment = value
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    // Old version
    func addSubscribers() {
        $selectedReaction
            .sink(receiveValue: updateTopReact(selectedReaction:))
            .store(in: &cancellables)
    }
    
    // For internal news...
    func getUserStatus() {
        for react in self.allReact {
            if String(react.employeeId) == userInfor.employeeId {
                self.isReacted = true
                self.selectedReaction = react.reactType ?? 6
            }
        }
    }
    
    func getTop2React() -> [String] {
        
        var top2React = [String]()
        
        if contentType == Constants.ReactContentType.INTERNAL_NEWS {
            
            var react = self.reactCount
            
            for _ in 0..<2 {
                let max = react.max()
                let maxIndex = react.firstIndex(of: max!)!
                if max != 0 {
                    let imgName = convertReactCodeToImageName(maxIndex)
                    if !imgName.isEmpty {
                        top2React.append(convertReactCodeToImageName(maxIndex))
                    }
                }
                react[maxIndex] = 0
            }
        } else {
            if self.reactTop1 != 6 {
                top2React.append(convertReactCodeToImageName(reactTop1))
            }
            if self.reactTop2 != 6 {
                top2React.append(convertReactCodeToImageName(reactTop2))
            }
            
        }
        
        return top2React
    }
    
    func convertReactCodeToImageName(_ react: Int) -> String {
        switch react {
        case Constants.ReactType.LIKE:
            return "ic_fb_like"
        case Constants.ReactType.LOVE:
            return "ic_fb_love"
        case Constants.ReactType.LAUGH:
            return "ic_fb_laugh"
        case Constants.ReactType.SAD:
            return "ic_fb_sad"
        case Constants.ReactType.ANGRY:
            return "ic_fb_angry"
        default:
            //Do nothing
            return ""
        }
    }
    
    // For recognition...
    func updateTopReact(selectedReaction: Int) {
        
        DispatchQueue.main.async {
            if selectedReaction != 6  {
                if self.reactTop1 == 6 {
                    self.reactTop1 = selectedReaction
                } else if self.reactTop2 == 6 && self.reactTop1 != selectedReaction {
                    self.reactTop2 = selectedReaction
                }
            } else {
                if self.reactTop2 == self.previousReaction {
                    self.reactTop2 = 6
                } else if self.reactTop1 == self.previousReaction {
                    self.reactTop1 = 6
                }
            }
        }
    }
}
