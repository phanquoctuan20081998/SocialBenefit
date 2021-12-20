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
    
    @Published var walletInfor = WalletInforData.sampleData
    @Published var allRecognitionPost = [RecognitionData]()
    
    private var walletInforService = WalletInforService()
    private var recognitionService = RecognitionService()
    
    init() {
        loadWalletInfor()
        loadRecognitionData()
    }
    
    func loadWalletInfor() {
        walletInforService.getAPI { data in
            DispatchQueue.main.async {
                self.walletInfor = data
            }
        }
    }
    
    func loadRecognitionData() {
        recognitionService.getListByCompany(fromIndex: 0) { [weak self] data in
            DispatchQueue.main.async {
                self?.allRecognitionPost = data
            }
        }
    }
}
