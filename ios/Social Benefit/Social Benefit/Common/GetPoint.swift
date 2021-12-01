//
//  GetPoint.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 01/12/2021.
//

import Foundation
import SwiftUI

@ViewBuilder
func getPointString(point: Int) -> some View {
    if point == 1 || point == 0 {
        Text("\(point) \("point".localized)")
            .fontWeight(.medium)
    } else {
        Text("\(point) \("points".localized)")
            .fontWeight(.medium)
    }
}
