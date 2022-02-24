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
            if(notificationCardViewModel.notificationItem.getType() == Constants.NotificationLogType.COMMENT) || (notificationCardViewModel.notificationItem.getType() == Constants.NotificationLogType.RECOGNIZE) || (notificationCardViewModel.notificationItem.getType() == Constants.NotificationLogType.COMMENT_RECOGNITION){
                URLImageView(url: notificationCardViewModel.image)
                    .clipShape(Circle())
                    .padding(.all, 5)
                    .frame(width: 70, height: 70)
                    .overlay(Circle().stroke(Color("nissho_blue"), lineWidth: 3))
                    .padding(.leading, 5)
            } else {
                if (!notificationCardViewModel.image.isEmpty) {
                    Image(notificationCardViewModel.image)
                        .resizable()
                        .scaledToFit()
                        .padding(.all, 8)
                        .clipShape(Circle())
                        .frame(width: 70, height: 70)
                        .overlay(Circle().stroke(Color("nissho_blue"), lineWidth: 3))
                        .padding(.leading, 5)
                }
            }
            
            VStack(alignment: .leading) {
   
                HTMLView(htmlString: notificationCardViewModel.content)
                    .offset(x: -8)
          
                Spacer()
                
                HStack {
                    Text("\(notificationCardViewModel.date) \("at".localized) \(notificationCardViewModel.time)")
                    
                    Spacer()
                    
                    Text(notificationCardViewModel.point)
                        .bold()
                        .foregroundColor(.blue)
                }
            }.font(.system(size: 12))
        }
        .padding(10)
        .frame(width: ScreenInfor().screenWidth * 0.9, height: 110)
        .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("nissho_blue"), lineWidth: 3))
        
        .overlay(
            ZStack {
                if notificationItem.getStatus() == 0 {
                    Circle()
                        .fill(.red)
                        .frame(width: 8, height: 8)
                        .padding()
                }
            }, alignment: .topTrailing
        )
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
    }
    
}


struct NotificationCardView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCardView(notificationItem: NotificationItemData.sampleData[0])
    }
}
