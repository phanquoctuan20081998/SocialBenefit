//
//  Test.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/09/2021.
//

import SwiftUI
import SlidingTabView

struct Test: View {
    
    @State private var selectedTabIndex = 0
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var selectedInternalNew = InternalNewsData()
    @State var isActive = false
    
    var body: some View {
        
        NavigationView {
            EmptyView()
        }.overlay(
            VStack {
                HStack {
                    HStack {
                        Button(action: {
                            //Do something
                            
                        }, label: {
                            Image(systemName: "arrow.backward")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .padding(.leading, 20)
                        })
                        
                        Text("internal_news".localized)
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    URLImageView(url: userInfor.companyLogo)
                        .frame(height: 30)
                        .padding(.all, 15)
                }
                
                SearchBarView(searchText: $searchText, isSearching: $isSearching)
                
                SlidingTabView(selection: self.$selectedTabIndex, tabs: ["all".localized, "training".localized, "annoucement".localized])
            }
        )
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
