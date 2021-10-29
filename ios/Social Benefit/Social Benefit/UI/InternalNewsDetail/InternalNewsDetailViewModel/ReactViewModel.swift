//
//  ReactViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 07/09/2021.
//

import Foundation

class ReactViewModel: ObservableObject, Identifiable {
    
    @Published var allReact = [ReactData]()
    @Published var numOfReact: Int = 0
    @Published var reactCount = [0, 0, 0, 0, 0, 0, 0, 0]
    
//    @Published var numOfLike: Int = 0 // reactType = 0
//    @Published var numOfLove: Int = 0 // reactType = 1
//    @Published var numOfLaugh: Int = 0 // reactType = 2
//    @Published var numOfSad: Int = 0 // reactType = 4
//    @Published var numOfAngry: Int = 0 // reactType = 5
    
    @Published var isLike: Bool = false
    @Published var selectedReaction: Int = 6 // 6 is "" in reactions constant
    @Published var isShowReactionBar: Bool = false
    
    private let reactService = ReactService()
    
    init(contentId: Int) {
        initComment(contentId: contentId)
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
                    case Constants.ReactType.ANGER:
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
    
    func getUserStatus() {
        for react in self.allReact {
            if String(react.employeeId) == userInfor.employeeId {
                self.isLike = true
                self.selectedReaction = react.reactType ?? 6
            }
        }
    }
    
    func getTop3React() -> [String] {
        var top3React = [String]()
        
        var react = self.reactCount
        
        for _ in 0..<3 {
            let max = react.max()
            let maxIndex = react.firstIndex(of: max!)!
            if max != 0 {
                switch maxIndex {
                case Constants.ReactType.LIKE:
                    top3React.append("ic_fb_like")
                case Constants.ReactType.LOVE:
                    top3React.append("ic_fb_love")
                case Constants.ReactType.LAUGH:
                    top3React.append("ic_fb_laugh")
                case Constants.ReactType.SAD:
                    top3React.append("ic_fb_sad")
                case Constants.ReactType.ANGER:
                    top3React.append("ic_fb_angry")
                default:
                    //Do nothing
                    print("")
                }
            }
            react[maxIndex] = 0
        }
        return top3React
    }
}
