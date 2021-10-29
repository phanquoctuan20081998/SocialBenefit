//
//  Test.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import SwiftUI
import WebKit
import SDWebImageSwiftUI




struct Test: View {
    @State var index = 0
    
    @State var isMove = false
    var images = ["htt://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif", "https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif", "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic"]
    
    var body: some View {
        VStack(spacing: 20) {
            PagingView(index: $index.animation(), maxIndex: images.count - 1) {
                ForEach(self.images, id: \.self) { imageName in
                    URLImageView(url: imageName)
//                    WebImage(url: URL(string: imageName), isAnimating: $isAnimating)
                        .scaledToFill()
                }
            }
            .aspectRatio(4/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            
            
//            Stepper("Index: \(index)", value: $index.animation(.easeInOut), in: 0...images.count-1)
//                            .font(Font.body.monospacedDigit())
        }
        .padding()
        
        
//        NavigationView {
//            VStack {
//                ScrollView {
//                    ZStack(alignment: .bottom) {
//                        ImageGallery(isMove: $isMove, images: images)
//                    }
//                    .frame(width: ScreenInfor().screenWidth * 0.92, height: 200)
//                    .cornerRadius(30)
//                }
//                Spacer()
//                    .frame(height: 100)
//                //                }
//
//            }
//            .background(BackgroundViewWithNotiAndSearch())
//            .background(
//                NavigationLink(destination: Text("shsa"), isActive: $isMove, label: {
//                    EmptyView()
//                })
//            )
//        }
    }
    
    
}

//struct ImageGallery: View {
//    @State var isAnimating: Bool = true
//    @Binding var isMove: Bool
//    var images: [String]
//    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
//    @State private var currentPage = 0
//    
//    var body: some View {
//        if images.count != 0 { //If Data can read
//            PageViewController(pages: getData(data: images), currentPage: $currentPage)
//                .onReceive(self.timer) { _ in self.currentPage = (self.currentPage + 1) % images.count }
//            PageControl(numberOfPages: images.count, currentPage: $currentPage)
//                
//        } else {
//            EmptyView()
//        }
//    }
//    
//    func getData(data: [String]) -> [AnyView] {
//        var a = [AnyView]()
//        for image in images {
//            a.append(
//                AnyView(
//                    
//                    WebImage(url: URL(string: image), isAnimating: $isAnimating)
//                        .placeholder(Image(systemName: "photo")) // Placeholder Image
//                    // Supports ViewBuilder as well
//                        .placeholder {
//                            Circle().foregroundColor(.gray)
//                        }
//                        .resizable()
//                        .scaledToFill()
//                        .onTapGesture {
//                            isMove = true
//                        }
//                )
//            )
//        }
//        return a
//    }
//}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
