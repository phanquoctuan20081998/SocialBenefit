//
//  SpecialOffersViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/09/2021.
//

import Foundation

class SpecialOffersViewModel: ObservableObject, Identifiable {
    @Published var allSpecialOffers = [MerchantVoucherItemData]()
    @Published var searchPattern: String = ""
    @Published var fromIndex: Int = -1
    @Published var category: Int = -1
    
    private let specialOffersService = SpecialOffersService()
    
    init(searchPattern: String, fromIndex: Int, categoryid: Int) {
        specialOffersService.getAPI(searchPattern: searchPattern, fromIndex: fromIndex, categoryId: categoryid) { data in
            DispatchQueue.main.async {
                self.allSpecialOffers = data
            }
            
        }
    }
}
