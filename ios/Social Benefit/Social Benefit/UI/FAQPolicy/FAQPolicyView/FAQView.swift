//
//  FAQView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 27/01/2022.
//

import SwiftUI

struct FAQView: View {
    
    @ObservedObject var faqPolicyViewModel = FAQPolicyViewModel(docType: Constants.DocumentType.FAQ)
                                                                            
    var body: some View {
        FAQPolicyView(faqPolicyViewModel: faqPolicyViewModel)
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQPolicyView(faqPolicyViewModel: FAQPolicyViewModel(docType: Constants.DocumentType.FAQ))
    }
}
