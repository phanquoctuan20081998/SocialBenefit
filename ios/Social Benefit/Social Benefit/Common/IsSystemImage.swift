//
//  isSystemImage.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/10/2021.
//

import Foundation
import UIKit

func isSystemImage(image: String) -> Bool {
    
    if let _ = UIImage(named: image) {
        return false
    } else {
        return true
    }
}
