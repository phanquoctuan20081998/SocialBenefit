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
        
        if homeScreen.isPresentedSearchView {
            VStack {
                HStack(spacing: 15) {
                    SearchBarView(searchText: $searchText, isSearching: $isSearching, placeHolder: "your_searching_screen".localized, width: ScreenInfor().screenWidth * 0.8, height: 50, fontSize: 15, isShowCancelButton: false)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            homeScreen.isPresentedTabBar = true
                            homeScreen.isPresentedSearchView = false
                        }
                        
//                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("close".localized)
                    }
                }
                
                contentView
            }
            .background(Color.white.edgesIgnoringSafeArea(.all).frame(width: ScreenInfor().screenWidth))
            .onAppear {
                homeScreen.isPresentedTabBar = false
            }
        }
    }
}

