//
//  Med247ViewControllerRepresentation.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 22/01/2022.
//

import UIKit
import SwiftUI

struct Med247ViewControllerRepresentation: UIViewControllerRepresentable {
   
    typealias UIViewControllerType = Med247ViewController
    
    func makeUIViewController(context: Context) -> Med247ViewController {
        let vc = Med247ViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: Med247ViewController, context: Context) {
        
    }
}
