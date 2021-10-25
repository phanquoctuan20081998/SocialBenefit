//
//  CustomerPopUpViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/10/2021.
//

import Foundation
import Combine

class CustomerSupportViewModel: ObservableObject, Identifiable {
    @Published var isPresentCustomerSupportPopUp: Bool = true
    
    @Published var screenProblemText: String = ""
    @Published var feedBackText: String = ""
    
    @Published var isAllTextFieldAreTyped = false
    @Published var isAllTextFieldAreBlank = true
    
    @Published var isLoading = false
    @Published var isSuccessed = true
    
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
            self.isAllTextFieldAreTyped = !screenProblemText.isEmpty && !self.feedBackText.isEmpty
            self.isAllTextFieldAreBlank = screenProblemText.isEmpty && self.feedBackText.isEmpty
        }
    }
    
    func loadfeedBackText(feedBackText: String) {
        DispatchQueue.main.async {
            self.isAllTextFieldAreTyped = !self.screenProblemText.isEmpty && !feedBackText.isEmpty
            self.isAllTextFieldAreBlank = self.screenProblemText.isEmpty && feedBackText.isEmpty
        }
    }
    
    func sendButtonTapped() {
        self.isLoading = true
        DispatchQueue.main.async {
            self.customerSupportService.getAPI(screen: self.screenProblemText, content: self.feedBackText) { id in
                print(id)
                self.isLoading = false
                self.isSuccessed = true
            }
        }
    }
}
