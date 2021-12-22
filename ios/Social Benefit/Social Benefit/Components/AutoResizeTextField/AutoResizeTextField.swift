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
    @Binding var isFocus: Bool
    var textfieldType: Int
    var onEnd: () -> ()
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.isScrollEnabled = true
        textView.alwaysBounceVertical = false
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        
        textView.text = text
        textView.backgroundColor = UIColor.clear
        
        if textfieldType == Constants.AutoResizeTextfieldType.RECOGNITION_ACTION {
            textView.font = UIFont.systemFont(ofSize: 20)
        } else {
            textView.font = UIFont.systemFont(ofSize: 13)
        }
        
        context.coordinator.textView = textView
        textView.delegate = context.coordinator
        textView.layoutManager.delegate = context.coordinator
        
        // Input Accessory View...
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.barStyle = .default
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "done".localized, style: .done, target: context.coordinator, action: #selector(context.coordinator.closeKeyBoard))
        
        toolBar.items = [spacer, doneButton]
        toolBar.sizeToFit()
        
        textView.inputAccessoryView = toolBar

        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    
    func makeCoordinator() -> Coordinator {
        return Coordinator(dynamicSizeTextField: self, isFocus: $isFocus)
    }
}

class Coordinator: NSObject, UITextViewDelegate, NSLayoutManagerDelegate {
    
    var dynamicHeightTextField: DynamicHeightTextField
    @Binding var isFocus: Bool
    weak var textView: UITextView?

    
    init(dynamicSizeTextField: DynamicHeightTextField, isFocus: Binding<Bool>) {
        self.dynamicHeightTextField = dynamicSizeTextField
        _isFocus = isFocus
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        DispatchQueue.main.async {
            self.isFocus = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        DispatchQueue.main.async {
            self.isFocus = false
        }
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
    @Binding var isFocus: Bool
    
    var minHeight: CGFloat
    var maxHeight: CGFloat
    var placeholder: String
    var textfiledType: Int = Constants.AutoResizeTextfieldType.DEFAULT

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
            if text.isEmpty {
                if textfiledType == Constants.AutoResizeTextfieldType.RECOGNITION_ACTION {
                    Text(placeholder)
                        .foregroundColor(Color.gray)
                        .padding(15)
                } else if textfiledType == Constants.AutoResizeTextfieldType.CUSTOMER_SUPPORT {
                    Text(placeholder)
                        .font(.system(size: 15))
                        .foregroundColor(Color(UIColor.placeholderText))
                        .padding(10)
                } else {
                    Text(placeholder)
                        .font(.system(size: 13))
                        .foregroundColor(Color(UIColor.placeholderText))
                        .padding(5)
                }
            }
            
            DynamicHeightTextField(text: $text, height: $textHeight, isFocus: $isFocus, textfieldType: textfiledType, onEnd: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }).padding(textfiledType == Constants.AutoResizeTextfieldType.RECOGNITION_ACTION ? 10 : 5)
        }
        .frame(height: textFieldHeight)
    }
}

struct Test1View: View {
    @State var text = ""
    @State var isFocus = false
    
    var body: some View {
        
        AutoResizeTextField(text: $text, isFocus: $isFocus, minHeight: 30, maxHeight: 80, placeholder: "type_comment".localized)
            .clipShape(RoundedRectangle(cornerRadius: 20))
//            .padding(5)
            
            .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(Color.blue.opacity(0.5), lineWidth: 2))
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
//        Test1View()
        CustomerSupportPopUp()
            .environmentObject(CustomerSupportViewModel())
    }
}


