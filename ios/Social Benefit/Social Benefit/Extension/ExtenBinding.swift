//
//  ExtenBinding.swift
//  Social Benefit
//
//  Created by chu phuong dong on 26/11/2021.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ hander: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: {
                self.wrappedValue
            }, set: { selection in
                self.wrappedValue = selection
                hander(selection)
            })
    }
}
