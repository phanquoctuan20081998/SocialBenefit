//
//  NavigationLazyView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 31/12/2021.
//

import Foundation
import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
