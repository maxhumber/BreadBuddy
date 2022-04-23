import SwiftUI

public struct SafariButton<Label: View>: View {
    @State private var isPresented = false
    private var url: URL
    private var label: Label

    public init(urlString: String?, @ViewBuilder label: () -> Label) {
        if let urlString = urlString, let url = URL(string: urlString) {
            self.url = url
        } else {
            self.url = URL(string: "https://")!
        }
        self.label = label()
    }
    
    public var body: some View {
        Button {
            isPresented = true
        } label: {
            label
        }
        .sheet(isPresented: $isPresented) {
            SafariView(url).edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct SafariButton_Previews: PreviewProvider {
    static var previews: some View {
        SafariButton(urlString: "https://google.com") {
            Text("google.com")
        }
    }
}
