//
//  ResetSuccessView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/10/2021.
//

import SwiftUI

struct ResetSuccessView: View {
    
    @State var isTapped = false
    
    var body: some View {
//        NavigationView {
            ZStack(alignment: .top) {
                VStack {
                    Image("pic_background")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
                
                VStack(spacing: 20) {
                    
                    Spacer().frame(height: 100)
                    
                    //URLImageView(url: userInfor.companyLogo)
                    Image("pic_company_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    
                    Spacer().frame(height: 30)
                    
                    Text("success_notification".localized)
                        .font(.system(size: 15))
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                        .frame(width: ScreenInfor().screenWidth * 0.8)
                    
                    Button {
                        isTapped.toggle()
                    } label: {
                        Text("login".localized)
                            .foregroundColor(.black)
                            .padding(.init(top: 10, leading: 50, bottom: 10, trailing: 50))
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("nissho_light_blue"))
                            )
                            .font(.system(size: 15))
                    }
                    
                    Spacer()
                    
                }
                
                NavigationLink(destination: LoginView().navigationBarHidden(true), isActive: $isTapped) {
                    EmptyView()
                }
            }.edgesIgnoringSafeArea(.all)
//        }
    }
}

struct ResetSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        ResetSuccessView()
    }
}
