//
//  FavoriteMerchantDeatilViewModel.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 16/02/2022.
//

import Foundation

class FavoriteMerchantViewModel: ObservableObject, Identifiable {
    @Published var selectedFavoriteMerchant = FavoriteMerchantResultModel()
    
    init(merchant: FavoriteMerchantResultModel) {
        selectedFavoriteMerchant = merchant
    }
}
