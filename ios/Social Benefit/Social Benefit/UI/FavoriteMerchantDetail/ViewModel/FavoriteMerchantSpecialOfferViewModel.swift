//
//  FavoriteMerchantSpecialOfferViewModel.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 15/02/2022.
//

import Foundation
import Combine

class FavoriteMerchantSpecialOfferViewModel: ObservableObject, Identifiable {
    @Published var allSpecialOffers: [MerchantVoucherItemData] = []
    @Published var allMerchantOffers = []
    @Published var merchantId: Int = 0
    @Published var fromIndex: Int = 0

    // Loading & refreshing
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    private let specialOffersService = MerchantVoucherSpecialListService()
    private var cancellables = Set<AnyCancellable>()
    
    init(merchantId: Int) {
        self.merchantId = merchantId
        loadData()
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.fromIndex = 0
            self.loadData()
        }
    }
    
    func loadData() {
        self.isLoading = true
        specialOffersService.getAPI(searchPattern: "", fromIndex: 0, categoryId: -1) { data in
            DispatchQueue.main.async {
                self.allSpecialOffers = data
                
                self.isLoading = false
                self.isRefreshing = false
            }
        }
    }
    
    func reLoadData() {
        specialOffersService.getAPI(searchPattern: "", fromIndex: fromIndex, categoryId: -1) { [self] data in
            DispatchQueue.main.async {
                for item in data {
                    self.allSpecialOffers.append(item)
                }
            }
        }
    }
}
