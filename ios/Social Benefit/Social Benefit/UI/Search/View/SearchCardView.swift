//
//  SearchCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/10/2021.
//

import SwiftUI

struct SearchCardView: View {
    
    var icon: String
    var color: Color
    var title: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 3, y: 3)
                            .frame(width: ScreenInfor().screenWidth * 0.95, height: 50, alignment: .leading)
            
            HStack(spacing: 20) {
                if !isSystemImage(image: icon){
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(color)
                        .frame(width: 25, height: 25)
                } else {
                    Image(systemName: icon)
                        .resizable()
                        .foregroundColor(color)
                        .frame(width: 25, height: 25)
                }
                
                Text(title.localized)
                    .font(.system(size: 15))
            }.padding(.leading, 20)
        }
    }
}

struct SearchCardView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCardView(icon: "home_my_profile", color: Color.yellow, title: "dcbhdsbchjs")
    }
}
