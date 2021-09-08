//
//  AutoResizeTextField.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 08/09/2021.
//

import Foundation
import SwiftUI

struct DynamicHeightTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var height: CGFloat
    var onEnd: () -> ()
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.isScrollEnabled = true
        textView.alwaysBounceVertical = false
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        
        textView.text = text
        textView.backgroundColor = UIColor.white
        
        context.coordinator.textView = textView
        textView.delegate = context.coordinator
        textView.layoutManager.delegate = context.coordinator
        
        // Input Accessory View...
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.barStyle = .default
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(context.coordinator.closeKeyBoard))
        
        toolBar.items = [spacer, doneButton]
        toolBar.sizeToFit()
        
        textView.inputAccessoryView = toolBar

        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    
    func makeCoordinator() -> Coordinator {
        return Coordinator(dynamicSizeTextField: self)
    }
}

class Coordinator: NSObject, UITextViewDelegate, NSLayoutManagerDelegate {
    
    var dynamicHeightTextField: DynamicHeightTextField
    
    weak var textView: UITextView?

    
    init(dynamicSizeTextField: DynamicHeightTextField) {
        self.dynamicHeightTextField = dynamicSizeTextField
    }
    
    //Keyboard closed
    @objc func closeKeyBoard() {
        self.dynamicHeightTextField.onEnd()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.dynamicHeightTextField.text = textView.text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func layoutManager(_ layoutManager: NSLayoutManager, didCompleteLayoutFor textContainer: NSTextContainer?, atEnd layoutFinishedFlag: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            guard let textView = self?.textView else {
                return
            }
            let size = textView.sizeThatFits(textView.bounds.size)
            if self?.dynamicHeightTextField.height != size.height {
                self?.dynamicHeightTextField.height = size.height
            }
        }

    }
}

struct AutoResizeTextField: View {

    @Binding var text: String
    var minHeight: CGFloat
    var maxHeight: CGFloat
    var placeholder: String

    @State var textHeight: CGFloat = 0

    var textFieldHeight: CGFloat {

        if textHeight < minHeight {
            return minHeight
        }

        if textHeight > maxHeight {
            return maxHeight
        }

        return textHeight
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(UIColor.secondarySystemBackground)

            

            DynamicHeightTextField(text: $text, height: $textHeight, onEnd: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
                .if(text.isEmpty) {view in
                    view.overlay(Text(placeholder)
                                    .foregroundColor(Color(UIColor.placeholderText))
                                    .padding(10), alignment: .leading)
                    
                }
                

        }
        .frame(height: textFieldHeight)
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
                            AutoResizeTextField(text: .constant(""), minHeight: 30, maxHeight: 70, placeholder: "adbhdbhsd")
    }
}


