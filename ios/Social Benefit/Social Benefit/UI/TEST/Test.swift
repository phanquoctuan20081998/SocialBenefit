//
//  Test.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import SwiftUI
import WebKit
import SDWebImageSwiftUI

struct PagingView<Content>: View where Content: View {

    @Binding var index: Int
    let maxIndex: Int
    let content: () -> Content
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    @State private var offset = CGFloat.zero
    @State private var dragging = false


    init(index: Binding<Int>, maxIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self._index = index
        self.maxIndex = maxIndex
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        self.content()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }
                .content.offset(x: self.offset(in: geometry), y: 0)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture(minimumDistance: 30, coordinateSpace: .local).onChanged { value in
                        self.dragging = true
                        self.offset = -CGFloat(self.index) * geometry.size.width + value.translation.width
                    }
                    .onEnded { value in
                        let predictedEndOffset = -CGFloat(self.index) * geometry.size.width + value.predictedEndTranslation.width
                        let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
                        self.index = self.clampedIndex(from: predictedIndex)
                        withAnimation(.easeOut) {
                            self.dragging = false
                        }
                    }
                )
            }
            .clipped()

            PageControl1(index: $index, maxIndex: maxIndex)
                .onReceive(self.timer) { _ in self.index = (self.index + 1) % (maxIndex + 1) }
        }
    }

    func offset(in geometry: GeometryProxy) -> CGFloat {
        if self.dragging {
            return max(min(self.offset, 0), -CGFloat(self.maxIndex) * geometry.size.width)
        } else {
            return -CGFloat(self.index) * geometry.size.width
        }
    }

    func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
        guard newIndex >= 0 else { return maxIndex }
        guard newIndex <= maxIndex else { return 0 }
        return newIndex
    }
}

struct PageControl1: View {
    @Binding var index: Int
    let maxIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                Circle()
                    .fill(index == self.index ? Color.white : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
        .allowsHitTesting(false)
        .padding(15)
    }
}


struct Test: View {
    @State var index = 0
    @State var isAnimating: Bool = true
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentPage = 0
    @State var isMove = false
    var images = ["https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif", "https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif", "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic"]

    var body: some View {
//        VStack(spacing: 20) {
//            PagingView(index: $index.animation(), maxIndex: images.count - 1) {
//                ForEach(self.images, id: \.self) { imageName in
////                    URLImageView(url: imageName)
//                    WebImage(url: URL(string: imageName), isAnimating: $isAnimating)
//                        .resizable()
//                        .scaledToFill()
//                }
//            }
//            .aspectRatio(4/3, contentMode: .fit)
//            .clipShape(RoundedRectangle(cornerRadius: 15))
//
//
//
////            Stepper("Index: \(index)", value: $index.animation(.easeInOut), in: 0...images.count-1)
////                .font(Font.body.monospacedDigit())
//        }
//        .padding()
        
        
        NavigationView {
            VStack(spacing: 15) {
                ZStack(alignment: .bottom) {
                    if images.count != 0 { //If Data can read
                        PageViewController(pages: getData(data: images), currentPage: $currentPage)
                        PageControl(numberOfPages: images.count, currentPage: $currentPage)
                            .onReceive(self.timer) { _ in self.currentPage = (self.currentPage + 1) % images.count }
                    } else {
                        EmptyView()
                    }
                }
            }
            .frame(width: ScreenInfor().screenWidth * 0.92, height: 200)
            .background(Color.white)
            .cornerRadius(30)
            .background(
                NavigationLink(destination: Text("shsa"), isActive: $isMove, label: {
                    EmptyView()
                })
            )
        }
    }
    
    func getData(data: [String]) -> [AnyView] {
        var a = [AnyView]()
        for image in images {
            a.append(
                AnyView(
                    
                    WebImage(url: URL(string: image), isAnimating: $isAnimating)
                        .resizable()
                        .scaledToFill()
                        .onTapGesture {
                            isMove = true
                            print(isMove)
                        }
                )
            )
        }
        return a
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
