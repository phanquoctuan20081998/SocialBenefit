//
//  CustomTabBarView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/08/2021.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @Binding var selectedTab: String
    @State var tabPoint: [CGFloat] = []
    
    var body: some View {
        HStack(spacing: 0) {
            
            // Tab Bar Buttons
            TabBarButtonView(buttonImage: "house", buttonName: "home".localized, selectedTab: $selectedTab, tabPoint: $tabPoint)
            TabBarButtonView(buttonImage: "star", buttonName: "recognition".localized, selectedTab: $selectedTab, tabPoint: $tabPoint)
            TabBarButtonView(buttonImage: "tag", buttonName: "promotion".localized, selectedTab: $selectedTab, tabPoint: $tabPoint)
            TabBarButtonView(buttonImage: "person.circle", buttonName: "user".localized, selectedTab: $selectedTab, tabPoint: $tabPoint)
            
        }
        .frame(height: 50)
        .edgesIgnoringSafeArea(.bottom)
        .background(
            Color.white
//                .clipShape(TabCurveShape(tabPoint: getCurvePoint()))
//                .background(Color.blue.opacity(0.2))
                .background(Color.white)
                .edgesIgnoringSafeArea(.bottom)
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
    
    func getCurvePoint() -> CGFloat {
        if tabPoint.isEmpty {
            return 10
        }
        else {
            switch selectedTab {
            case "house":
                return tabPoint[3]
            case "star":
                return tabPoint[2]
            case "tag":
                return tabPoint[1]
            default:
                return tabPoint[0]
            }
        }
    }
}

struct TabBarButtonView: View {
    
    var buttonImage: String
    var buttonName: String
    @Binding var selectedTab: String
    @Binding var tabPoint: [CGFloat]
    
    var body: some View {
        
        // For getting midpoint of each button for curve animation
        GeometryReader { reader -> AnyView in
            
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.global().async(execute: {
                DispatchQueue.main.sync {
                    if tabPoint.count <= 4 {
                        tabPoint.append(midX)
                    }
                }
            })
            
            return AnyView(
                Button(action: {
                    // Changing tab
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
                        selectedTab = buttonImage
                    }
                }, label: {
                    
                    VStack(spacing: 3) {
                        Image(systemName: "\(buttonImage)\(selectedTab == buttonImage ? ".fill" : "")")
                            .font(.system(size: 20, weight: .semibold))
                        Text(buttonName)
                            .font(.system(size: 13, weight: .light))
                            .padding(.top, 0.01)
                    }
                    .foregroundColor(selectedTab == buttonImage ? .blue : .black)
                    //Lifting view if its selected
                        .offset(y: 0)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }.frame(height: 50)
    }
}




struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}


