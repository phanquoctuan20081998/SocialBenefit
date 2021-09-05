//
//  LoadURLImage.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 27/08/2021.
//

import Foundation
import SwiftUI

extension String {
    func loadURLImage() -> UIImage {
        do {
            let urlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            guard let url = URL(string: urlString!) else {
                return UIImage()
            }
            let data: Data = try Data(contentsOf: url)
            let image = UIImage(data: data) ?? UIImage()
            
            return image
            
        } catch {
            
        }
        return UIImage()
    }
}
