//
//  designMaterial.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/08/2021.
//

import UIKit
import SwiftUI

extension UIView {
    func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
    }
    
    func circleCorner() {
          superview?.layoutIfNeeded()
          setCorner(radius: frame.height / 2)
      }
    
    func setBorder(width: CGFloat, color: UIColor) {
            layer.borderColor = color.cgColor
            layer.borderWidth = width
        }
}

extension UITextField {
    func setPlaceHolder(text: String) {
        placeholder = NSLocalizedString(text, comment: "")
        textAlignment = .left
    }
}


struct RoundedCornersShape: Shape {
    
    let radius: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    
    func cornerRadius(radius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(RoundedCornersShape(radius: radius, corners: corners))
    }
}
