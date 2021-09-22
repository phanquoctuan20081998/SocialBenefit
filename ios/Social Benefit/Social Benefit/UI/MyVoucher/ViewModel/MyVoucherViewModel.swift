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
    
    @Published var searchPattern: String = ""
    @Published var fromIndex: Int = 0
    @Published var status: Int = 0
    
    private let myVoucherService = MyVoucherService()
    private var cancellables = Set<AnyCancellable>()
    
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
        myVoucherService.getAPI(searchPattern: searchPattern, fromIndex: fromIndex, status: status) { data in
            DispatchQueue.main.async {
                self.allMyVoucher = data
            }
        }
    }
    
    func loadStatus(status: Int) {
        myVoucherService.getAPI(searchPattern: searchPattern, fromIndex: fromIndex, status: status) { data in
            DispatchQueue.main.async {
                self.allMyVoucher = data
            }
        }
    }
    
}

let myVoucherDeBug = [MyVoucherData(id: 1807, title: "Chào hè ưu đãi khủng", cover: "", expriedDate: DateFormatter().date(from: "2021-09-21 10:11:28 +0000")!, merchantName: "Đệm Liên Á"),
                      MyVoucherData(id: 1807, title: "Chào hè ưu đãi khủng", cover: "", expriedDate: DateFormatter().date(from:"2021-09-21 10:11:28 +0000")!, merchantName: "Đệm Liên Á"),
                      MyVoucherData(id: 1807, title: "Chào hè ưu đãi khủng", cover: "", expriedDate: DateFormatter().date(from:"2021-09-21 10:11:28 +0000")!, merchantName: "Đệm Liên Á"),
                      MyVoucherData(id: 1807, title: "Chào hè ưu đãi khủng", cover: "", expriedDate: DateFormatter().date(from: "2021-09-21 10:11:28 +0000")!, merchantName: "Đệm Liên Á"),
                      MyVoucherData(id: 1830, title: "Giảm giá áo thu đông 2021", cover: "", expriedDate: DateFormatter().date(from: "2021-09-25 03:20:00 +0000")!, merchantName: "Đệm Liên Á"),
                      MyVoucherData(id: 1767, title: "Voucher_16082021_3", cover: "/files/4180/images - Copy.png", expriedDate: DateFormatter().date(from: "2021-09-30 10:05:00 +0000")!, merchantName: "Mỹ phầm Coco"),
                      MyVoucherData(id: 1767, title: "Voucher_16082021_3", cover: "/files/4180/images - Copy.png", expriedDate: DateFormatter().date(from: "2021-09-30 10:05:00 +0000")!, merchantName: "Mỹ phầm Coco"),
                      MyVoucherData(id: 1839, title: "Bảo dưỡng xe máy", cover: "", expriedDate: DateFormatter().date(from: "2021-10-11 04:36:00 +0000")!, merchantName: "Toyota"),
                      MyVoucherData(id: 1839, title: "Bảo dưỡng xe máy", cover: "", expriedDate: DateFormatter().date(from: "2021-10-11 04:36:00 +0000")!, merchantName: "Toyota"),
                      MyVoucherData(id: 1839, title: "Bảo dưỡng xe máy", cover: "", expriedDate: DateFormatter().date(from: "2021-10-11 04:36:00 +0000")!, merchantName: "Toyota")]
