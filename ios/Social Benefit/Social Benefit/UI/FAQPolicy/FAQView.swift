//
//  FAQView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 27/01/2022.
//

import SwiftUI

struct FAQView: View {
    
    @State var isPresentError: Bool = false
    @State var error: String = ""
    
    let currentLang = Constants.LANGUAGE_CODE[UserDefaults.standard.integer(forKey: "language")]
                                                                            
    var body: some View {
        ZStack {
            BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "", isHaveLogo: false)
            
            
            // Error
            ErrorMessageView(error: error, isPresentedError: $isPresentError)
        }
        .onAppear {
            FAQPolicyService().getAPI(docType: Constants.DocumentType.FAQ, lang_code: currentLang) { data in
                let errors = data["errors"].string ?? ""
                
                if !errors.isEmpty {
                    self.error = errors
                    self.isPresentError = true
                } else {
                    
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
