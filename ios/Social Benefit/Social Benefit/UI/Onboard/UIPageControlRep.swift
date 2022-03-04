//
//  UIPageControlRep.swift
//  Social Benefit
//
//  Created by chu phuong dong on 01/03/2022.
//

import Foundation
import UIKit
import SwiftUI

struct UIPageControlRep: UIViewRepresentable {
    
    @Binding var currentPage: Int
    
    let numberOfPages: Int
    
    func makeUIView(context: UIViewRepresentableContext<UIPageControlRep>) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.init(named: "nissho_blue")
        pageControl.isUserInteractionEnabled = false
        pageControl.hidesForSinglePage = true
        return pageControl
    }
    
    func updateUIView(_ pageControl: UIPageControl, context: Context) {
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
    }
}
