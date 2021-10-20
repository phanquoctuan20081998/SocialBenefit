//
//  MyVoucherViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 22/09/2021.
//

import Foundation
import Combine

class MyVoucherViewModel: ObservableObject, Identifiable {
    
//    @Published var allMyVoucher = [MyVoucherData]()
    @Published var allMyVoucher = myVoucherDeBug
    @Published var selectedVoucherCode = VoucherCodeData(voucherCode: "", remainTime: 0)
    
    // API controller...
    @Published var searchPattern: String = ""
    @Published var fromIndex: Int = 0
    @Published var status: Int = 0
    @Published var isSearching: Bool = false
    
    // PopUp controller...
    @Published var isPresentedQRPopup: Bool = false
    @Published var isPresentedReBuyPopup: Bool = false
    
    // Refreshing and Loading
    
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    private let myVoucherService = MyVoucherService()
    private var cancellables = Set<AnyCancellable>()
    
    let generateCodeService = GenerateCodeService()
    
    init() {
        loadSearchData(searchPattern: "")
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchPattern
            .sink(receiveValue: loadSearchData(searchPattern:))
            .store(in: &cancellables)
        
        $status
            .sink(receiveValue: loadStatus(status:))
            .store(in: &cancellables)
    }
    
    func loadSearchData(searchPattern: String) {
        self.isLoading = true
        myVoucherService.getAPI(searchPattern: searchPattern, fromIndex: 0, status: status) { [weak self] data in
            DispatchQueue.main.async {
                self?.allMyVoucher = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func loadStatus(status: Int) {
        self.isLoading = true
        myVoucherService.getAPI(searchPattern: searchPattern, fromIndex: 0, status: status) {[weak self] data in
            DispatchQueue.main.async {
                self?.allMyVoucher = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func reloadData() {
        myVoucherService.getAPI(searchPattern: searchPattern, fromIndex: fromIndex, status: status) { [weak self] data in
            DispatchQueue.main.async {
                for item in data {
                    self?.allMyVoucher.append(item)
                }
            }
        }
    }
    
    func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.loadSearchData(searchPattern: "")
        }
    }
}


let myVoucherDeBug = [MyVoucherData(id: 1807, status: 1, voucherOrderId: 5, title: "Chào hè ưu đãidfdfsasascascacascascascascascascacacacacacacdfgdfgdfgdfgdfgdgdfgdfgdgdgd khủng", cover: "", expriedDate: Date() + 1, merchantName: "Đệm Liên Á"),
                      MyVoucherData(id: 1767, status: 2, voucherOrderId: 5, title: "Voucher_16082021_3", cover: "/files/4180/images - Copy.png", expriedDate: Date(), merchantName: "Mỹ phầm Coco"),
                      MyVoucherData(id: 1767, status: 3, voucherOrderId: 5, title: "Voucher_16082021_3", cover: "/files/4180/images - Copy.png", expriedDate: Date(), merchantName: "Mỹ phầm Coco")]
