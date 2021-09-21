//
//  CustomTabBarView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/08/2021.
//

import SwiftUI

var tabs = ["Home", "Recognition", "Promotion", "User"]
var tabImages = ["house", "star", "tag", "person.circle"]

struct CustomTabBarView: View {
    
    @Binding var offset: CGFloat
    @State var width: CGFloat = 0
    
    var body: some View {
        
        EmptyView()
//
//        HStack(spacing: 0) {
//            ForEach(tabs.indices, id: \.self) { index in
//                VStack(spacing: 3) {
//                    let isChoosed = ScreenInfor().screenWidth * CGFloat(index - 1) < offset && offset <= ScreenInfor().screenWidth * CGFloat(index)
//
//                    Image(systemName: isChoosed ? tabImages[index] + ".fill" : tabImages[index])
//                        .foregroundColor(isChoosed ? .blue : .black)
//                        .font(.system(size: 20, weight: .semibold))
//
//
//                    Text(tabs[index])
//                        .frame(width: self.width)
//                        .font(.system(size: 13, weight: .light))
//                        .foregroundColor(isChoosed ? .blue : .black)
//                }
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    withAnimation {
//                        offset = ScreenInfor().screenWidth * CGFloat(index)
//                    }
//                }
//            }
//            .padding(.top, 5)
//            .edgesIgnoringSafeArea(.bottom)
//            .frame(height: ScreenInfor().screenHeight * 0.1, alignment: .top)
//            .background(Color.white)
//            .onAppear {
//                self.width = ScreenInfor().screenWidth / CGFloat(tabs.count)
//            }
//        }
    }
    
    func getOffset() -> CGFloat {
        let progress = offset / ScreenInfor().screenWidth
        return progress * width
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
                    
                    VStack {
                        Image(systemName: "\(buttonImage)\(selectedTab == buttonImage ? ".fill" : "")")
                            .font(.system(size: 20, weight: .semibold))
                        Text(buttonName)
                            .font(.system(size: 13, weight: .light))
                            .padding(.top, 0.01)
                    }
                        .foregroundColor(.black)
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
        CustomTabBarView(offset: .constant(CGFloat(0)))
    }
}


