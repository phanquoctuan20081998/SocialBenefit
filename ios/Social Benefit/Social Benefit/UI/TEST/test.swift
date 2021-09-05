import SwiftUI

//struct PageView<Page: View>: View {
//    var pages: [Page]
//    @State private var currentPage = 0
//
//    var body: some View {
//        ZStack(alignment: .bottomTrailing) {
//            PageViewController(pages: pages, currentPage: $currentPage)
//            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
//                .frame(width: CGFloat(pages.count * 18))
//                .padding(.trailing)
//        }
//    }
//}

//struct ContentView: View {
//    var image: String
//
//    var body: some View {
//        Image(image)
//            .resizable()
//            .scaledToFill()
//    }
//}

//struct PageView_Previews: PreviewProvider {
//    static var previews: some View {
//        PageView(pages: [ContentView(image: "phim1"), ContentView(image: "phim2"), ContentView(image: "phim3")])
//            .clipShape(RoundedRectangle(cornerRadius: 15))
//            .frame(width: ScreenInfor().screenWidth * 0.9, height: 200)
//    }
//}
