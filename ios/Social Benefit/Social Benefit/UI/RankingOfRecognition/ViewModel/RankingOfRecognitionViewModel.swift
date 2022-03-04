//
//  RankingOfRecognitionViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 28/11/2021.
//

import Foundation
import Combine

class RankingOfRecognitionViewModel: ObservableObject, Identifiable {
    @Published var fromIndex: Int = 0
    @Published var limit: Int = 10
    //    @Published var allRankingList = [RankingOfRecognitionData]()
    @Published var allRankingList: [RankingOfRecognitionData] = []
    
    @Published var myRank = RankingOfRecognitionData.sampleData[0]
    
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    private var recognitionService = RecognitionService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData(fromIndex: self.fromIndex)
        loadMyRankDetail()
    }

    func loadData(fromIndex: Int) {
        self.isLoading = true
        
        recognitionService.getRankingList(fromIndex: self.fromIndex, limit: self.limit) { [weak self] data in
            DispatchQueue.main.async {
                self?.allRankingList = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func loadMyRankDetail() {
        self.isLoading = true
        
        recognitionService.getMyRankDetail { [weak self] data in
            DispatchQueue.main.async {
                self?.myRank = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.fromIndex = 0
            self.loadData(fromIndex: self.fromIndex)
        }
    }
    
    func reloadData() {
        self.isLoading = true
        
        recognitionService.getRankingList(fromIndex: self.fromIndex, limit: self.limit) { [weak self] data in
            DispatchQueue.main.async {
                for i in data {
                    self?.allRankingList.append(i)
                }
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
}
