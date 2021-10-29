//
//  HomeViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/10/2021.
//

import Foundation

class HomeViewModel: ObservableObject, Identifiable {
    @Published var isAnimating: Bool = true
    @Published var isPresentInternalNewDetail: Bool = false
    @Published var isPresentVoucherDetail: Bool = false
    
    
    @Published var selectedIndex: Int? = nil
    @Published var selectedInternalNew: InternalNewsData? = nil
    @Published var selectedVoucherId: Int? = nil
}
