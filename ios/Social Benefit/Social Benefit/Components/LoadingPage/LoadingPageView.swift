//
//  LoadingPageView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 12/10/2021.
//

import SwiftUI

struct LoadingPageView: View {
    var body: some View {
        VStack {
            Spacer()
            ActivityRep()
            Text("loading".localized.uppercased())
            Spacer()
        }
    }
}

struct LoadingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPageView()
    }
}
