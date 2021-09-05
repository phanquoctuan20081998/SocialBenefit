//
//  URLImageViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/09/2021.
//

import Foundation
import SwiftUI
import Combine

class URLImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let urlImage: String
    private let dataService: URLImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(url: String) {
        self.urlImage = url
        self.dataService = URLImageService(url: url)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
