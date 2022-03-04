//
//  SplashView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 17/01/2022.
//

import SwiftUI

struct SplashView: View {
    @State var animationFinished: Bool = false
    
    var body: some View {
        ZStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                URLImageView(url: userInfor.companyLogo)
                    .scaledToFit()
                    .frame(width: ScreenInfor().screenWidth * 0.8, height: 150)
            }
            
            if animationFinished {
                if !UserDefaults.getShowOnboarding() {
                    OnboardingView()
                } else {
                    LoginView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 0.7)) {
                    animationFinished = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
