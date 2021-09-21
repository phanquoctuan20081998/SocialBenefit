import SwiftUI




struct Home: View {
    
    @ObservedObject var internalNewsViewModel = InternalNewsViewModel()
    
    @State var isPresentedTabBar = true
    
    @State var offset: CGFloat = 0
    @State var selectedTab = "house"
    
    var body: some View {
        GeometryReader { proxy in
            ScrollableTabBar(tabs: tabs, rect: proxy.frame(in: .global), offset: $offset) {
                HStack(spacing: 0 ){
                    HomeView(isPresentedTabBar: $isPresentedTabBar)

                    Rectangle().fill(Color.white)

                    ListOfMerchantView()
     
                    UserView(isPresentedTabBar: $isPresentedTabBar)

                }
            }.edgesIgnoringSafeArea(.all)
        }
//        .overlay(CustomTabBarView(selectedTab: $selectedTab), alignment: .bottom)
        .overlay(TabBar(offset: $offset), alignment: .bottom)
        .environmentObject(internalNewsViewModel)
    }
}


struct TabBar: View {
    @Binding var offset: CGFloat
    @State var width: CGFloat = 0
    
    var body: some View {
        
        let equalWidth = ScreenInfor().screenWidth / CGFloat(tabs.count)
        
        DispatchQueue.main.async {
            self.width = equalWidth
        }
        
        return ZStack(alignment: .bottomLeading) {
           
            
            HStack(spacing: 0) {
                ForEach(tabs.indices, id: \.self) { index in
                    VStack(spacing: 3) {
                        let isChoosed = ScreenInfor().screenWidth * CGFloat(index - 1) < offset && offset <= ScreenInfor().screenWidth * CGFloat(index)
                        
                        Image(systemName: isChoosed ? tabImages[index] + ".fill" : tabImages[index])
                            .foregroundColor(isChoosed ? .blue : .black)
                            .font(.system(size: 20, weight: .semibold))
                            
                        
                        Text(tabs[index])
                            .frame(width: equalWidth)
                            .font(.system(size: 13, weight: .light))
                            .foregroundColor(isChoosed ? .blue : .black)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            offset = ScreenInfor().screenWidth * CGFloat(index)
                        }
                    }
                }
            }.padding(.top)
            .frame(height: 50)
        }
    }
    
    func getOffset() -> CGFloat {
        let progress = offset / ScreenInfor().screenWidth
        return progress * width
    }
}


struct ScrollableTabBar_Preview: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(InternalNewsViewModel())
    }
}
