//
//  FavoriteMerchantsViewModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 15/02/2022.
//

import Foundation
import Combine

class FavoriteMerchantsViewModel: ObservableObject {
    
    @Published var isSearching = false
    
    @Published var isLoading = false
    
    @Published var keyword = ""
    
    @Published var error: AppError = .none
    
    private var cancellables = Set<AnyCancellable>()
    
    private let service = FavoriteMerchantService()
    
    @Published private var canLoadMore = true
    
    @Published var listMerchant: [FavoriteMerchantResultModel] = []
    
    init() {
        addSubscribers()
        requestFavoriteMerchant()
    }
    
    func addSubscribers() {
        $keyword
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .dropFirst()
            .sink(receiveValue: { [weak self] _ in
                self?.requestFavoriteMerchant(true)
            })
            .store(in: &cancellables)
    }
    
    func requestFavoriteMerchant(_ keywordChange: Bool = false) {
        if ((!isLoading && canLoadMore) || keywordChange) {
            isLoading = true
            if keywordChange {
                canLoadMore = true
                listMerchant.removeAll()
            }
            service.request(keyword: keyword, fromIndex: listMerchant.count) { response in
                self.isLoading = false
                switch response {
                case .success(let value):
                    if let result = value.result {
                        if keywordChange {
                            self.listMerchant = result
                        } else {
                            self.listMerchant.append(contentsOf: result)
                        }
                        if (result.isEmpty || result.count < Constants.MAX_NUM_API_LOAD) {
                            self.canLoadMore = false
                        }
                    } else {
                        self.canLoadMore = false
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
}
