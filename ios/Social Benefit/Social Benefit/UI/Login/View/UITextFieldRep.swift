//
//  FocusTextFieldStyle.swift
//  Social Benefit
//
//  Created by chu phuong dong on 07/12/2021.
//

import Foundation
import SwiftUI
import UIKit

struct UITextFieldRep: UIViewRepresentable {
    
    @Binding var text: String
    var isSecure: Bool
    @Binding var isFocused: Bool
    var placeholder: String?
    
    func makeUIView(context: UIViewRepresentableContext<UITextFieldRep>) -> UITextField {
        let tf = UITextField(frame: .zero)
        tf.isUserInteractionEnabled = true
        tf.delegate = context.coordinator
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        return tf
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isFocused: $isFocused)
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.isSecureTextEntry = isSecure
        uiView.placeholder = placeholder
        uiView.layer.borderWidth = 1
        uiView.layer.cornerRadius = 8
        uiView.layer.masksToBounds = true
        if isFocused {
            uiView.layer.borderColor = UIColor.blue.cgColor
        } else {
            uiView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isFocused: Bool

        init(text: Binding<String>, isFocused: Binding<Bool>) {
            _text = text
            _isFocused = isFocused
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
               self.isFocused = true
            }
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.isFocused = false
            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }
    }
}

struct LoginTextField: View {
    @Binding var text: String
    var isSecure: Bool
    @State private var isFocused = false
    var placeholder: String?
    
    var body: some View {
        UITextFieldRep.init(text: $text, isSecure: isSecure, isFocused: $isFocused, placeholder: placeholder)
        .padding()
        .frame(height: 50)
    }
}
