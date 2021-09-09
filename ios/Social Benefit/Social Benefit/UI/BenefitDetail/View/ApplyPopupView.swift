//
//  ApplyPopUp.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import SwiftUI

struct ApplyPopupView: View {
    
    @Binding var isPresented: Bool
    @Binding var isApplied: Bool
    var benefitId: Int
    
    var body: some View {
        ZStack {
            if self.isPresented {
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.isPresented = false
                    }
                
                popupContent
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                           .fill(Color.white)
                    )
                    .frame(width: ScreenInfor().screenWidth * 0.8, height: 150)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .foregroundColor(.black)
    }
}

extension ApplyPopupView {
    
    var popupContent: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("apply_this_benefit".localized)
                    .font(.system(size: 20, weight: .bold, design: .default))
                Text("want_to_apply".localized)
                    .padding(.top, 5)
            }.padding()
            
            Spacer()
            
            HStack {
                Spacer()
                HStack(spacing: 20) {
                    Button(action: {
                        self.isPresented = false
                    }, label: {
                        Text("cancel_button".localized)
                    })
                    
                    Button(action: {
                        ApplyBenefitService().getAPI(benefitId: benefitId)
                        self.isPresented = false
                        self.isApplied = true
                    }, label: {
                        Text("ok_button".localized)
                    })
                }.foregroundColor(.blue)
                .padding()
            }
        }
    }
}

struct ApplyPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ApplyPopupView(isPresented: .constant(true), isApplied: .constant(false), benefitId: 0)
    }
}
