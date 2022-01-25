//
//  Med247ViewControllerRepresentation.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 22/01/2022.
//

import UIKit
import SwiftUI

struct Med247ViewControllerRepresentation: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
    typealias UIViewControllerType = Med247ViewController
    
    func makeUIViewController(context: Context) -> Med247ViewController {
        let str = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = str.instantiateViewController(withIdentifier: "Med247ViewController") as! Med247ViewController
        vc.delegate = context.coordinator
        return vc
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(owner: self)
    }
    
    func updateUIViewController(_ uiViewController: Med247ViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, Med247ViewControllerDelegate {
        let owner: Med247ViewControllerRepresentation
        
        init(owner: Med247ViewControllerRepresentation) {
            self.owner = owner
        }
        
        func dissmissView() {
            self.owner.presentationMode.wrappedValue.dismiss()
        }
                
    }
}

