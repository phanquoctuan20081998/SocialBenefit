//
//  CheckBox.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/10/2021.
//

import SwiftUI

struct CheckBox: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color.blue : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}


struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(checked: .constant(true))
    }
}
