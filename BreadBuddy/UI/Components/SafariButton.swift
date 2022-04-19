import SafariServices
import SwiftUI

struct SafariButton<Label: View>: View {
    var url: URL
    var label: Label
    @State private var isPresented = false
    
    init(url: () -> URL, @ViewBuilder label: () -> Label) {
        self.url = url()
        self.label = label()
    }
    
    var body: some View {
        Button {
            isPresented = true
        } label: {
            label
        }
        .sheet(isPresented: $isPresented) {
            SafariView(url)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

fileprivate struct SafariView: UIViewControllerRepresentable {
    var url: URL
    
    init(_ url: URL) {
        self.url = url
    }
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

struct SafariButton_Previews: PreviewProvider {
    static var previews: some View {
        SafariButton {
            URL(string: "https://google.com")!
        } label: {
            Text("google.com")
        }
    }
}

