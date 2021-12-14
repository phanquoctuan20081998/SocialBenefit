//
//  GetPoint.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 01/12/2021.
//

import Foundation
import SwiftUI

@ViewBuilder
func getPointView(point: Int) -> some View {
    if point == 1 || point == 0 {
        Text("\(point) \("point".localized)")
            .fontWeight(.medium)
    } else {
        Text("\(point) \("points".localized)")
            .fontWeight(.medium)
    }
}

func getPointString(point: Int) -> String {
    if point == 1 || point == 0 {
        return "\(point) \("point".localized)"
    } else {
        return "\(point) \("points".localized)"
    }
}

func getPointStringOnly(point: Int) -> String {
    if point == 1 || point == 0 {
        return "\("point".localized)"
    } else {
        return "\("points".localized)"
    }
}
