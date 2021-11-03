import SwiftUI
import WebKit

struct MiniWebView : UIViewRepresentable {
    
    
    let request: URLRequest
    var webview: WKWebView?
    
    init(web: WKWebView?, req: URLRequest) {
        self.webview = WKWebView()
        self.request = req
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        return webview!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func goBack(){
        webview?.goBack()
    }
    
    func goForward(){
        webview?.goForward()
    }
}


struct FullWebView : View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let webview = MiniWebView(web: nil, req: URLRequest(url: URL(string: "http://222.252.19.197:8694/vnpt_online/portal/source/")!))
    
    var body: some View {
        VStack {
            
            VStack {
                Spacer().frame(height: 30)
                
                HStack{
                    Button(action: {
                        if webview.webview?.url == URL(string: "http://222.252.19.197:8694/vnpt_online/portal/source/")! {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        //do something
                        self.webview.goBack()
                    }){
                        Image(systemName: "arrow.left")
                            .font(.system(size: 25))
                    }.padding(.leading, 10)
                        .padding(5)
                    
                    Spacer()
                    
                    Text("VNPT")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                    
                    Spacer().frame(width: 170)
                }.padding(.top, 10)
                webview
            }.background(Color.white)
            
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct Previews: PreviewProvider {
    static var previews: some View {
        FullWebView()
    }
}

