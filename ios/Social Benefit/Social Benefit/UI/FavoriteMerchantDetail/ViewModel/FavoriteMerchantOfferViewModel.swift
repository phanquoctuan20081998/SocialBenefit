//
//  FavoriteMerchantOfferViewModel.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 15/02/2022.
//

import Foundation
import Combine

class FavoriteMerchantOfferViewModel: ObservableObject, Identifiable {
    @Published var allOffers = [MerchantVoucherItemData]()
    
    @Published var fromIndex: Int = 0
    @Published var categoryId: Int = -1
    
    // Loading & refreshing
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    private let offersService = MerchantVoucherListByCategoryService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData()
    }

    
    func loadData() {
        self.isLoading = true
        offersService.getAPI(searchPattern: "", fromIndex: 0, categoryId: -1, filterConditionItems: "[]") { data in
            DispatchQueue.main.async {
                self.allOffers = data
                
                self.isLoading = false
                self.isRefreshing = false
            }
        }
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.fromIndex = 0
            self.loadData()
        }
    }
    
    func reLoadData() {
        offersService.getAPI(searchPattern: "", fromIndex: fromIndex, categoryId: -1, filterConditionItems: "[]") { data in
            DispatchQueue.main.async {
                for item in data {
                    self.allOffers.append(item)
                }
            }
        }
    }
}
