//import SwiftUI
//
//struct ScrollableTabBar<Content: View>: UIViewRepresentable {
//
//    var content: Content
//    var rect: CGRect
//
//    @Binding var offset: CGFloat
//    let scrollView = UIScrollView()
//
//    var tabs: [Any]
//
//    init(tabs: [Any], rect: CGRect, offset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
//        self.content = content()
//        self._offset = offset
//        self.rect = rect
//        self.tabs = tabs
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return ScrollableTabBar.Coordinator(parent: self)
//    }
//
//    func makeUIView(context: Context) -> UIScrollView {
//        setUpScrollView()
//        scrollView.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
//        scrollView.addSubview(extractView())
//        scrollView.delegate = context.coordinator
//        return scrollView
//    }
//
//    func updateUIView(_ uiView: UIScrollView, context: Context) {
//
//        if uiView.contentOffset.x != offset {
//
//            uiView.delegate = nil
//
//            UIView.animate(withDuration: 0.4) {
//                uiView.contentOffset.x = offset
//            } completion: { (status) in
//                if status {
//                    uiView.delegate = context.coordinator
//                }
//            }
//        }
//    }
//
//    func setUpScrollView() {
//        scrollView.isPagingEnabled = true
//        scrollView.bounces = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
//    }
//
//    func extractView() -> UIView {
//        let controller = UIHostingController(rootView: content)
//        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
//        return controller.view!
//    }
//
//    class Coordinator: NSObject, UIScrollViewDelegate {
//
//        var parent: ScrollableTabBar
//
//        init(parent: ScrollableTabBar) {
//            self.parent = parent
//        }
//
//        func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            parent.offset = scrollView.contentOffset.x
//        }
//    }
//}
//
//
//struct Home: View {
//
////    @ObservedObject var internalNewsViewModel = InternalNewsViewModel()
//
//    @State var isPresentedTabBar = true
//
//    @State var offset: CGFloat = 0
//
//    var body: some View {
//        GeometryReader { proxy in
//            ScrollableTabBar(tabs: tabs, rect: proxy.frame(in: .global), offset: $offset) {
//                HStack(spacing: 0 ){
//                    HomeView()
//
//                    Rectangle().fill(Color.white)
//
//                    ListOfMerchantView()
//
//                    UserView()
//
//                }
//            }.edgesIgnoringSafeArea(.all)
//        }.overlay(TabBar(offset: $offset), alignment: .bottom)
//    }
//}
//
//struct TabBar: View {
//    @Binding var offset: CGFloat
//    @State var width: CGFloat = 0
//
//    var body: some View {
//
//        let equalWidth = ScreenInfor().screenWidth / CGFloat(tabs.count)
//
//        DispatchQueue.main.async {
//            self.width = equalWidth
//        }
//
//        return ZStack(alignment: .bottomLeading) {
//            Capsule()
//                .fill(Color.blue)
//                .frame(width: equalWidth - 15, height: 4)
//                .offset(x: getOffset() + 7, y: 4)
//
//            HStack(spacing: 0) {
//                ForEach(tabs.indices, id: \.self) { index in
//                    Text(tabs[index])
//                        .fontWeight(.bold)
//                        .frame(width: equalWidth, height: 40)
//                        .contentShape(Rectangle())
//                        .onTapGesture {
//                            withAnimation {
//                                offset = ScreenInfor().screenWidth * CGFloat(index)
//                            }
//                        }
//                }
//            }.frame(maxWidth: .infinity)
//        }
//    }
//
//    func getOffset() -> CGFloat {
//        let progress = offset / ScreenInfor().screenWidth
//        return progress * width
//    }
//}
//var tabs = ["Home", "Recognition", "Promotion", "User"]
//
//struct ScrollableTabBar_Preview: PreviewProvider {
//    static var previews: some View {
//        Home()
//            .environmentObject(InternalNewsViewModel())
//    }
//}
