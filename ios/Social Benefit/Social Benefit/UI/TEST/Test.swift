import SwiftUI
import ScrollViewProxy

struct ScrollViewTest: View {
   @State var categories: [String] = ["Cat One", "Cat Two", "Cat Three", "Cat Four"]
   @State private var proxy: AmzdScrollViewProxy? = nil
   @State private var currentCategory: String?
   
   var body: some View {
       VStack(alignment: .leading) {
           ScrollView(.horizontal, showsIndicators: false) {
               HStack(spacing: 30) {
                   ForEach(categories, id: \.self) { category in
                       Button(action: {
                           DispatchQueue.main.async {
                               currentCategory = category
                           }
                           if let proxy = proxy {
                               DispatchQueue.main.async {
                                   proxy.scrollTo(category, alignment: .top, animated: true)
                               }
                           }
                       }) {
                           Text(category)
                               .foregroundColor(currentCategory == category ? Color.black : Color.blue)
                               .fixedSize(horizontal: true, vertical: true)
                       }
                   }
               }
               .padding(.horizontal)
           }
           
           ScrollView(.vertical, showsIndicators: false) {
            AmzdScrollViewReader { proxy in
                   VStack(alignment: .leading, spacing: 30) {
                       ForEach(categories, id: \.self) { category in
                           VStack(alignment: .leading) {
                               Text(category)
                                   .font(.largeTitle)
                                   .foregroundColor(Color.black)
                               VStack(alignment: .leading) {
                                   ForEach(0..<12) { index in
                                       Text("Subview \(index)")
                                           .padding()
                                   }
                               }.padding(.top)
                           }
                           .scrollId(category)
                       }
                   }
                   .padding(.horizontal)
                   .onAppear { self.proxy = proxy }
               }
           }
       }
       .padding(.horizontal)
   }
   
}

struct test1: View {
    
    @State private var proxy: AmzdScrollViewProxy? = nil
    @State private var currentCategory: Int?
    
    var body: some View {
        VStack {
            Button(action: {
                self.currentCategory = 99
                if let proxy = proxy {
                    DispatchQueue.main.async {
                        proxy.scrollTo(currentCategory, alignment: .top, animated: true)
                    }
                }
            }, label: {
                Text("Button")
            })
            ScrollView {
                AmzdScrollViewReader { proxy in
                    VStack {
                        HStack {
                            Text("A")
                            Text("B")
                            Text("C")
                        }
                        ForEach(0..<100) {i in
                            Text("SubView \(i)")
                                .scrollId(i)
                        }
                    }
                    .onAppear { self.proxy = proxy }
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        test1()
    }
}
#endif
