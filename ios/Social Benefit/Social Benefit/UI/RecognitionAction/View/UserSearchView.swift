//
//  UserView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/12/2021.
//

import SwiftUI

struct UserSearchView: View {
    
    @EnvironmentObject var recognitionActionViewModel: RecognitionActionViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Infinite ScrollView controller
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        
        VStack(spacing: 10) {
            BackButtonView
            
            SearchBarView(searchText: $recognitionActionViewModel.searchText, isSearching: $recognitionActionViewModel.isSearching, placeHolder: "type_to_search".localized, width: ScreenInfor().screenWidth * 0.9, height: 30, fontSize: 18, isShowCancelButton: false)
                .padding(.vertical, 15)
            
            UserListView 
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension UserSearchView {
    
    var BackButtonView: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.backward")
                .scaledToFit()
                .font(.headline)
                .foregroundColor(.blue)
        }.frame(width: ScreenInfor().screenWidth * 0.9, alignment: .leading)
    }
    
    var UserListView: some View {
        RefreshableScrollView(height: 70, refreshing: self.$recognitionActionViewModel.isRefreshing) {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(recognitionActionViewModel.allUserList.indices, id: \.self) { index in
                        VStack {
                            
                            UserCardView(avatar: recognitionActionViewModel.allUserList[index].getAvatar(), userName: recognitionActionViewModel.allUserList[index].getFullName(), positionName: recognitionActionViewModel.allUserList[index].getPositionName(), departmentName: recognitionActionViewModel.allUserList[index].getDepartmentName(), isInUserView: false)
                            
                                .padding(.init(top: 10, leading: 20, bottom: 3, trailing: 20))
                                .frame(width: ScreenInfor().screenWidth, alignment: .leading)
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        if recognitionActionViewModel.isAddMoreClick {
                                            
                                            // If user is added
                                            if recognitionActionViewModel.isUserInUserList(user: recognitionActionViewModel.allUserList[index]) {
                                                recognitionActionViewModel.isPresentError = true
                                                recognitionActionViewModel.errorText = "this_person_is_exist"
                                            } else {
                                            
                                            // Create new element
                                            recognitionActionViewModel.allSelectedUser.append(recognitionActionViewModel.allUserList[index])
                                            recognitionActionViewModel.addTextControl()
                                            
                                            recognitionActionViewModel.realCount += 1
                                            recognitionActionViewModel.isAddMoreClick = false
                                            }
                                        } else {
                                            if self.recognitionActionViewModel.allSelectedUser[recognitionActionViewModel.selectedUserIndex].getId() == -1 {
                                                recognitionActionViewModel.realCount += 1
                                            }
                                            
                                            self.recognitionActionViewModel.allSelectedUser[recognitionActionViewModel.selectedUserIndex] = recognitionActionViewModel.allUserList[index]
                                        }
                                        
                                        self.recognitionActionViewModel.isModified = true
                                        self.presentationMode.wrappedValue.dismiss()
                                        recognitionActionViewModel.resetError()
                                    }
                                }
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: ScreenInfor().screenWidth, height: 1)
                            
                        }
                    }
                }
                //Infinite Scroll View
                
                if (recognitionActionViewModel.fromIndexUserList == recognitionActionViewModel.allUserList.count && isShowProgressView) {
                    
                    ActivityIndicator(isAnimating: true)
                    //                            .frame(width: ScreenInfor().screenWidth, alignment: .center)
                        .padding()
                        .onAppear {
                            
                            // Because the maximum length of the result returned from the API is 10...
                            // So if length % 10 != 0 will be the last queue...
                            // We only send request if it have more data to load...
                            if recognitionActionViewModel.allUserList.count % Constants.MAX_NUM_API_LOAD == 0 {
                                self.recognitionActionViewModel.reloadUserListData()
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
                        
                        if !recognitionActionViewModel.allUserList.isEmpty && minY < height && recognitionActionViewModel.allUserList.count >= Constants.MAX_NUM_API_LOAD  {
                            
                            DispatchQueue.main.async {
                                recognitionActionViewModel.fromIndexUserList = recognitionActionViewModel.allUserList.count
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
}

@ViewBuilder
func UserCardView(avatar: String, userName: String, positionName: String, departmentName: String, isInUserView: Bool) -> some View {
    HStack(spacing: 20) {
        URLImageView(url: avatar)
            .clipShape(Circle())
            .frame(width: 40, height: 40)
            .background(Color.white)
            .clipShape(Circle())
        
        VStack(alignment: .leading, spacing: 5) {
            Text(userName)
                .bold()
                .foregroundColor(.blue)
            
            HStack(spacing: 0) {
                Text("\(positionName) - \(departmentName)")
                    .fixedSize(horizontal: false, vertical: true)
            }
        }.frame(width: isInUserView ? ScreenInfor().screenWidth * 0.5 : ScreenInfor().screenWidth * 0.7, alignment: .leading)
    }.font(.system(size: 13))
}

struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
            .environmentObject(RecognitionActionViewModel())
    }
}
