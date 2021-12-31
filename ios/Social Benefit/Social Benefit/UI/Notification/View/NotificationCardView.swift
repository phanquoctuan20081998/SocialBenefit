//
//  NotificationCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 28/12/2021.
//

import SwiftUI

struct NotificationCardView: View {
    
    @ObservedObject var notificationCardViewModel: NotificationCardViewModel
    var notificationItem: NotificationItemData
    
    init(notificationItem: NotificationItemData) {
        self.notificationItem = notificationItem
        self.notificationCardViewModel = NotificationCardViewModel(notificationItemData: notificationItem)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Image(notificationCardViewModel.image)
                .resizable()
                .scaledToFit()
                .padding(.all, 10)
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .overlay(Circle().stroke(Color("nissho_blue"), lineWidth: 3))
            
            VStack(alignment: .leading) {
                HStack {
                    Text(notificationCardViewModel.notiTypeName + ": ")
                        .bold()
                    + Text(notificationCardViewModel.content)
                }.multilineTextAlignment(.leading)
                
                Spacer()
                
                HStack {
                    Text("\(notificationCardViewModel.date) \("at".localized) \(notificationCardViewModel.time)")
                    
                    Spacer()
                    
                    Text(notificationCardViewModel.point)
                        .bold()
                        .foregroundColor(.blue)
                    
                }
            }.font(.system(size: 15))
        }
        .padding()
        .frame(width: ScreenInfor().screenWidth * 0.9, height: 100)
        .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("nissho_blue"), lineWidth: 3))
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
    }
    
}

struct NotificationCardView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCardView(notificationItem: NotificationItemData.sampleData[0])
    }
}
