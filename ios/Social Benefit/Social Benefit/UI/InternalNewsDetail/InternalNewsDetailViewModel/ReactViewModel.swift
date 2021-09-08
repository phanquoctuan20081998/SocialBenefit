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
    @Published var numOfLike: Int = 0 // reactType = 0
    @Published var numOfLove: Int = 0 // reactType = 1
    @Published var numOfLaugh: Int = 0 // reactType = 2
    @Published var numOfSad: Int = 0 // reactType = 4
    @Published var numOfAngry: Int = 0 // reactType = 5
    
    @Published var isLike: Bool = false
    @Published var selectedReaction: Int = 6 // 6 is "" in reactions constant
    
    private let reactService: ReactService
    
    init(contentId: Int) {
        self.reactService = ReactService(contentId: contentId)
        initComment()
    }
    
    func initComment() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.allReact = self.reactService.allReact
            
            for react in self.allReact {
                switch react.reactType {
                case 0:
                    self.numOfLike += 1
                case 1:
                    self.numOfLove += 1
                case 2:
                    self.numOfLaugh += 1
                case 4:
                    self.numOfSad += 1
                case 5:
                    self.numOfAngry += 1
                default:
                    // More react
                    print("This \(String(describing: react.reactType)) reaction hasn't developed yet!")
                }
            }
            
            self.numOfReact = self.numOfLike + self.numOfLove + self.numOfLaugh + self.numOfSad + self.numOfAngry
            
            self.getUserStatus()
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
        
        var react = [self.numOfLike, self.numOfLove, self.numOfLaugh, self.numOfSad, self.numOfAngry]
        
        for _ in 0..<3 {
            let max = react.max()
            let maxIndex = react.firstIndex(of: max!)!
            if max != 0 {
                switch maxIndex {
                case 0:
                    top3React.append("ic_fb_like")
                case 1:
                    top3React.append("ic_fb_love")
                case 2:
                    top3React.append("ic_fb_laugh")
                case 3:
                    top3React.append("ic_fb_sad")
                default:
                    top3React.append("ic_fb_angry")
                }
            }
            react[maxIndex] = 0
        }
        return top3React
    }
}
