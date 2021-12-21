//
//  RadioButton.swift
//  Social Benefit
//
//  Created by chu phuong dong on 29/11/2021.
//

import SwiftUI

struct RadioButtonOptional: View {
    
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
            if model.checked == false {
                model.checked?.toggle()
            }
            action?()
        }, label: {
            HStack {
                Image(systemName: (model.checked ?? false) ? "smallcircle.fill.circle.fill" : "circle")
                    .foregroundColor((model.checked ?? false) ? Color.blue : Color.secondary)
                Text(buttonText).foregroundColor(Color.black)
            }
        })
        
        
    }
}

//struct RadioButton_Previews: PreviewProvider {
//    static var previews: some View {
//        RadioButtonOptional(checked: .constant(true), text: "string")
//    }
//}
