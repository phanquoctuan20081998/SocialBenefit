//
//  NotificationView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 28/12/2021.
//

import SwiftUI

struct NotificationView: View {
    
    @StateObject var notificationViewModel = NotificationViewModel()
    
    @State var isMoveToNextPage = false
    
    // Infinite ScrollView controller
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        VStack {
            if notificationViewModel.isLoading && !notificationViewModel.isRefreshing {
                Spacer()
                LoadingPageView()
                Spacer()
            } else {
                Spacer()
                    .frame(height: 70)
                
                RefreshableScrollView(height: 70, refreshing: self.$notificationViewModel.isRefreshing) {
                    NotificationListView
                        .padding(.top, 10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            notificationViewModel.loadNotificationItemsData(fromIndex: 0)
            notificationViewModel.destinationView = AnyView(LoadingView().navigationBarHidden(true))
        }
        .background(
            ZStack {
                if notificationViewModel.isNotLazyLoading {
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    NavigationLink(destination: notificationViewModel.destinationView, isActive: $isMoveToNextPage, label: {
                        EmptyView()
                    })
                } else {
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    NavigationLink(destination: NavigationLazyView(notificationViewModel.destinationView), isActive: $isMoveToNextPage, label: {
                        EmptyView()
                    })
                }
            }
        )
        .background(BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "notification".localized, isHaveLogo: true, isHiddenTabBarWhenBack: false, backButtonTapped: notificationViewModel.updateReadNotification))
        .navigationBarHidden(true)
    }
}

extension NotificationView {
    var NotificationListView: some View {
        VStack {
            ForEach(notificationViewModel.allNotificationItems.indices, id: \.self) { index in
                VStack {
                    
                    NotificationCardView(notificationItem: notificationViewModel.allNotificationItems[index])
                        .onTapGesture {
                            DispatchQueue.main.async {
                                notificationViewModel.changeDesitionationView(notificationItem: notificationViewModel.allNotificationItems[index])
                                notificationViewModel.updateReadNotification(items: [notificationViewModel.allNotificationItems[index]])
                                
                                if notificationViewModel.isMoveToNextPage(notificationItem: notificationViewModel.allNotificationItems[index]) {
                                    self.isMoveToNextPage = true
                                }
                            }
                        }
                    Spacer().frame(height: 20)
                    
                }
            }
            
            //Infinite Scroll View
            
            if (notificationViewModel.fromIndex == notificationViewModel.allNotificationItems.count && isShowProgressView) {
                
                ActivityIndicator(isAnimating: true)
                    .onAppear {
                        
                        // Because the maximum length of the result returned from the API is 10...
                        // So if length % 10 != 0 will be the last queue...
                        // We only send request if it have more data to load...
                        if notificationViewModel.allNotificationItems.count % Constants.MAX_NUM_API_LOAD == 0 {
                            self.notificationViewModel.reloadData()
                        }
                        
                        // Otherwise just delete the ProgressView after 1 seconds...
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.isShowProgressView = false
                        }
                        
                    }
                
            } else {
                GeometryReader { reader -> Color in
                    let minY = reader.frame(in: .global).minY
                    let height = ScreenInfor().screenHeight / 1.3
                    
                    if !notificationViewModel.allNotificationItems.isEmpty && minY < height && notificationViewModel.allNotificationItems.count >= Constants.MAX_NUM_API_LOAD  {
                        
                        DispatchQueue.main.async {
                            notificationViewModel.fromIndex = notificationViewModel.allNotificationItems.count
                            self.isShowProgressView = true
                        }
                    }
                    return Color.clear
                }
                .frame(width: 20, height: 20)
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
