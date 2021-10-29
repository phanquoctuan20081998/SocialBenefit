//
//  PopUpView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/10/2021.
//

import SwiftUI

struct PopUpView: View {
    
    @Binding var isPresentedPopUp: Bool
    var outOfPopUpAreaTapped: () -> ()
    var popUpContent: AnyView
    
    var body: some View {
        ZStack {
            if isPresentedPopUp {
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        outOfPopUpAreaTapped()
                    }
                
                popUpContent
                    .animation(.easeInOut)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .foregroundColor(.black)
    }
}
