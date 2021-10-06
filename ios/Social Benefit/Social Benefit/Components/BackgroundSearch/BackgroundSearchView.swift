//
//  SearchView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/10/2021.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var homeScreen: HomeScreenViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var contentView: AnyView
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 15) {
                    SearchBarView(searchText: $searchText, isSearching: $isSearching, placeHolder: "your_searching_screen".localized, width: ScreenInfor().screenWidth * 0.8, height: 50, fontSize: 15, isShowCancelButton: false)
                    
                    Button {
                        homeScreen.isPresentedTabBar = true
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("close".localized)
                    }
                }
                
                contentView
            }
            .onAppear {
                homeScreen.isPresentedTabBar = false
            }.navigationBarHidden(true)
        }
    }
}

