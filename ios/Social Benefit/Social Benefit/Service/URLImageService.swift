//
//  URLImageService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/09/2021.
//

import Foundation
import SwiftUI
import Combine

class URLImageService {
    
    @Published var image: UIImage? = nil
    
    private let urlImage: String
    private let imageName: String
    private let fileManager = LocalFileManager.instance
    private var imageSubscription: AnyCancellable?
    private let folderName = "urlimages"
    
    init(url: String) {
        self.urlImage = Constant.baseURL + url
        self.imageName = (url as NSString).lastPathComponent
        getURLImage()
    }
    
    private func getURLImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: urlImage) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
    
}

