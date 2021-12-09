//
//  RecentTransferListView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 03/12/2021.
//

import SwiftUI

extension RecognitionActionView {
    
    var RecentTransferListView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("recent_transfers".localized)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Button {
                    withAnimation {
                        recognitionActionViewModel.isShowRecentTransferList.toggle()
                    }
                } label: {
                    Text(recognitionActionViewModel.isShowRecentTransferList ? "hide".localized : "show".localized)
                        .underline()
                        .font(.system(size: 13))
                }
                
            }.frame(width: ScreenInfor().screenWidth * 0.93 - 15, alignment: .bottom)
            
            if recognitionActionViewModel.isShowRecentTransferList {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(self.recognitionActionViewModel.allTransfersList.indices, id: \.self) { i in
                            UserTransferView(avatar: recognitionActionViewModel.allTransfersList[i].getAvatar(), userName: recognitionActionViewModel.allTransfersList[i].getFullName())
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        
                                        // If user is added
                                        if recognitionActionViewModel.isUserInUserList(user: recognitionActionViewModel.allTransfersList[i]) {
                                            recognitionActionViewModel.userIsExistError = true
                                            
                                        // Else add user to list
                                        } else {
                                            
                                            if recognitionActionViewModel.allSelectedUser[0].getId() == -1 {
                                                recognitionActionViewModel.allSelectedUser[0] = recognitionActionViewModel.allTransfersList[i]
                                            } else {
                                                recognitionActionViewModel.allSelectedUser.append(recognitionActionViewModel.allTransfersList[i])
                                            }
                                            
                                            recognitionActionViewModel.realCount += 1
                                        }
                                    }
                                }
                        }
                        
                        //Infinite Scroll View
                        
                        if (self.recognitionActionViewModel.fromIndexTransferList == self.recognitionActionViewModel.allTransfersList.count && self.isShowProgressView) {
                            
                            ActivityIndicator(isAnimating: true)
                                .onAppear {
                                    
                                    // Because the maximum length of the result returned from the API is 10...
                                    // So if length % 10 != 0 will be the last queue...
                                    // We only send request if it have more data to load...
                                    if self.recognitionActionViewModel.allTransfersList.count % Constants.MAX_NUM_API_LOAD == 0 {
                                        self.recognitionActionViewModel.reloadTransferListData()
                                    }
                                    
                                    // Otherwise just delete the ProgressView after 1 seconds...
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.isShowProgressView = false
                                    }
                                    
                                }
                            
                        } else {
                            GeometryReader { reader -> Color in
                                let minX = reader.frame(in: .global).maxX
                                let width = ScreenInfor().screenWidth / 1.3
                                
                                if !self.recognitionActionViewModel.allTransfersList.isEmpty && minX < width && recognitionActionViewModel.allTransfersList.count >= Constants.MAX_NUM_API_LOAD {
                                    
                                    DispatchQueue.main.async {
                                        self.recognitionActionViewModel.fromIndexTransferList = self.recognitionActionViewModel.allTransfersList.count
                                        self.isShowProgressView = true
                                    }
                                }
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
                        }
                    }.padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
                }
            }
        }
    }
    
    @ViewBuilder
    func UserTransferView(avatar: String, userName: String) -> some View {
        VStack {
            URLImageView(url: avatar)
                .clipShape(Circle())
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.4), lineWidth: 3))
            
            Text(userName)
                .font(.system(size: 13))
                .multilineTextAlignment(.center)
        }.frame(width: 100, height: 80)
    }
}

struct RecognitionAction2View_Previews: PreviewProvider {
    static var previews: some View {
        RecognitionActionView()
    }
}
