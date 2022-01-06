//
//  CustomerPopUpViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/10/2021.
//

import Foundation
import Combine

class CustomerSupportViewModel: ObservableObject, Identifiable {
    @Published var isPresentCustomerSupportPopUp: Bool = false
    
    @Published var screenProblemText: String = ""
    @Published var feedBackText: String = ""
    
    @Published var isAllTextFieldAreTyped = false
    @Published var isAllTextFieldAreBlank = true
    
    @Published var isLoading = false
    @Published var isSuccessed = false
    
    private var cancellables = Set<AnyCancellable>()
    private var customerSupportService = CustomerSupportService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $screenProblemText
            .sink(receiveValue: loadScreenProblemText(screenProblemText:))
            .store(in: &cancellables)
        
        $feedBackText
            .sink(receiveValue: loadfeedBackText(feedBackText:))
            .store(in: &cancellables)
    }
    
    func resetText() {
        self.screenProblemText = ""
        self.feedBackText = ""
    }
    
    func loadScreenProblemText(screenProblemText: String) {
        DispatchQueue.main.async {
            self.isAllTextFieldAreTyped = !screenProblemText.isEmpty && !self.feedBackText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            self.isAllTextFieldAreBlank = screenProblemText.isEmpty && self.feedBackText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    func loadfeedBackText(feedBackText: String) {
        DispatchQueue.main.async {
            self.isAllTextFieldAreTyped = !self.screenProblemText.isEmpty && !feedBackText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            self.isAllTextFieldAreBlank = self.screenProblemText.isEmpty && feedBackText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    func sendButtonTapped() {
        self.isLoading = true
        
        self.customerSupportService.getAPI(screen: self.screenProblemText, content: self.feedBackText) { id in
            DispatchQueue.main.async {
                self.isLoading = false
                self.isSuccessed = true
            }
        }
    }
    
    func resetValue() {
        DispatchQueue.main.async {
            self.isSuccessed = false
            self.isPresentCustomerSupportPopUp = false
        }
    }
}
