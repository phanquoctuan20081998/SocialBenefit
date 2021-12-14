//
//  PostBannerView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/11/2021.
//

import SwiftUI

struct PostBannerView: View {
    
    @EnvironmentObject var recognitionPostViewModel: RecognitionPostViewModel
    
    var body: some View {
        ZStack {
            BackgroundView
            ContentView
        }
    }
}

extension PostBannerView {
    
    var BackgroundView: some View {
        ZStack {
            Image("bum")
                .resizable()
                .opacity(0.5)
            
            Image("giftbox")
                .resizable()
                .opacity(0.7)
                .frame(width: 90, height: 90)
                .offset(x: -130, y: 50)
            
            Image("giftbox")
                .resizable()
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .opacity(0.7)
                .frame(width: 90, height: 90)
                .offset(x: 130, y: -70)
            
        }
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
        .frame(width: ScreenInfor().screenWidth * 0.93, height: 200)
    }
    
    var ContentView: some View {
        VStack(spacing: 5) {
            
            Spacer()
            
            HStack(spacing: 15) {
                URLImageView(url: recognitionPostViewModel.recognitionDetailData.getSenderAvatar())
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                    .padding(.all, 5)
                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                
                VStack(alignment: .leading) {
                    Text(recognitionPostViewModel.recognitionDetailData.getSenderFullName())
                        .bold()
                        .font(.system(size: 18))
                    Text(recognitionPostViewModel.recognitionDetailData.getSenderJobDescription())
                        .font(.system(size: 14))
                }
            }.frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
            
            HStack(spacing: 15) {
                HStack(spacing: 0) {
                    Text("\("recgonize".localized) : ")
                    Text("\(recognitionPostViewModel.recognitionDetailData.getReceiverFullName())")
                        .bold()
                }
                URLImageView(url: recognitionPostViewModel.recognitionDetailData.getReceiverAvatar())
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                    .padding(.all, 5)
                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                
            }
            
            getPointView(point: recognitionPostViewModel.recognitionDetailData.getPoint())
                .font(.system(size: 25))
                .foregroundColor(.blue)
            
            Text(recognitionPostViewModel.recognitionDetailData.getRecognitionNote())
                .italic()
                .font(.system(size: 15))
            
            Spacer()
            
            Text(recognitionPostViewModel.getDate(date: recognitionPostViewModel.recognitionDetailData.getRecognitionTime()))
                .italic()
                .font(.system(size: 13))
                .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .trailing)
            
            Spacer()
            
        }.frame(width: ScreenInfor().screenWidth * 0.93, height: 200)
    }
}

struct PostBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PostBannerView()
            .environmentObject(RecognitionPostViewModel(id: 0))
    }
}
