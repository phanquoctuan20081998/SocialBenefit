//
//  CheckBoxOptional.swift
//  Social Benefit
//
//  Created by chu phuong dong on 01/12/2021.
//

import Foundation
import SwiftUI

struct CheckBoxOptional: View {
    @Binding var model: SurveyChoiceModel
    
    var action: (() -> Void)? = nil
    
    var buttonText: String {
        return model.isOption ? "your_survey_option".localized : model.choiceName
    }

    var body: some View {
        
        Button.init(action: {
            if model.checked == nil {
                model.checked = false
            }
            model.checked?.toggle()
            action?()
        }, label: {
            HStack {
                Image(systemName: (model.checked ?? false) ? "checkmark.square.fill" : "square")
                    .foregroundColor((model.checked ?? false) ? Color.blue : Color.secondary)
                Text(buttonText).foregroundColor(Color.black)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
            }
        })
    }
}
