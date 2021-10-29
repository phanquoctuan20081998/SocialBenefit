//
//  ImagePickerView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/10/2021.
//

import SwiftUI

struct ImagePickerView: View {
    
    @EnvironmentObject var userInformationViewModel: UserInformationViewModel
    
    var body: some View {
        
        DragPopUp(isPresent: $userInformationViewModel.isPresentedImagePicker, contentView: AnyView(contentView))
        
            .sheet(isPresented: $userInformationViewModel.showGallery) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    userInformationViewModel.image = image
                }
            }
        
            .sheet(isPresented: $userInformationViewModel.showCamera) {
                ImagePicker(sourceType: .camera) { image in
                    userInformationViewModel.image = image
                }
            }
    }
    
    var contentView: some View {
        VStack(alignment: .trailing, spacing: 20) {
            
            Spacer().frame(height: 10)
            
            VStack(spacing: 20) {
                Text("upload_picture_option".localized)
                    .bold()
                    .font(.system(size: 25))
                Text("how_do_you_want_to_set".localized)
            }.frame(width: ScreenInfor().screenWidth * 0.8)
            
            Spacer().frame(height: 10)
            
            HStack(spacing: 20) {
                Image(systemName: "camera.fill")
                Text("add_from_camera".localized)
            }.frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
                .onTapGesture {
                    userInformationViewModel.showCamera.toggle()
                    userInformationViewModel.isPresentedImagePicker.toggle()
                }
            
            HStack(spacing: 20) {
                Image(systemName: "photo.fill")
                Text("add_from_gallery".localized)
            }.frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
                .onTapGesture {
                    userInformationViewModel.showGallery.toggle()
                    userInformationViewModel.isPresentedImagePicker.toggle()
                }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(width: ScreenInfor().screenWidth, height: 250)
        .background(
            RoundedCornersShape(radius: 40, corners: [.topLeft, .topRight])
                .fill(Color.white)
        )
        .background(Rectangle()
                        .edgesIgnoringSafeArea(.bottom)
                        .offset(y: 50)
                        .foregroundColor(.white))
    }
}


struct ContentViewView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
            .environmentObject(UserInformationViewModel())
    }
}
