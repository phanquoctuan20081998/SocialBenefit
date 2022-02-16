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
                self?.requestFavoriteMerchant()
            })
            .store(in: &cancellables)
    }
    
    func requestFavoriteMerchant() {
        if !isLoading, canLoadMore {
            isLoading = true
            service.request(keyword: keyword, fromIndex: listMerchant.count) { response in
                self.isLoading = false
                switch response {
                case .success(let value):
                    self.listMerchant.append(contentsOf: value.result ?? [])
                    if (value.result ?? []).isEmpty {
                        self.canLoadMore = false
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
}
