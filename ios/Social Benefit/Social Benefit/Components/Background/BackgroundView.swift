//
//  BackgroundView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 25/08/2021.
//

import SwiftUI

struct BackgroundView: View {
    
    var body: some View {
        VStack {
            Image("pic_background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea([.top])
                .frame(width: ScreenInfor().screenWidth)
                .overlay(
                    HStack {
                        URLImageView(url: userInfor.companyLogo)
                            .frame(height: 30)
                            .padding(.leading)
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                // Do something
                                
                            }, label: {
                                Image(systemName: "bell.fill")
                            })
                            
                            Button(action: {
                                // Do something
                                
                            }, label: {
                                Image(systemName: "magnifyingglass")
                            })
                        }
                        .foregroundColor(.blue)
                        .padding(.trailing)
                        
                    }, alignment: .top)
            Spacer()
        }
    }
}

struct NoSearchBackgroundView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Image("pic_background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea([.top])
                .frame(width: ScreenInfor().screenWidth)
                .overlay(
                    HStack {
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                self.isActive.toggle()
                            }, label: {
                                VStack(alignment: .leading) {
                                    Image(systemName: "arrow.backward")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                        .padding(.leading, 20)
                                }
                            }).padding()
                            Spacer()
                        }
                        
                        URLImageView(url: userInfor.companyLogo)
                            .frame(height: 30, alignment: .trailing)
                            .padding(.trailing, 25)
                    }
                    
                    ,alignment: .top)
            
            Spacer()
        }
    }
}


struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfMerchantView()
    }
}

