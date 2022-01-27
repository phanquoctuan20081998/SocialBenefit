//
//  FAQView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 27/01/2022.
//

import SwiftUI

struct FAQView: View {
    
    let currentLang = Constants.LANGUAGE_CODE[UserDefaults.standard.integer(forKey: "language")]
                                                                            
    var body: some View {
        VStack {
            
        }
        .background(
            BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "", isHaveLogo: false)
        )
        .onAppear {
            FAQPolicyService().getAPI(docType: Constants.DocumentType.FAQ, lang_code: currentLang) { data in
                print(data)
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
