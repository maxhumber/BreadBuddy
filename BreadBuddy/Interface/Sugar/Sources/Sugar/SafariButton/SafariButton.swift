import SwiftUI

public struct SafariButton<Label: View>: View {
    var url: URL?
    var label: Label
    @State private var isPresented = false
    
    public init(url: URL?, @ViewBuilder label: () -> Label) {
        self.url = url
        self.label = label()
    }
    
    public var body: some View {
        Button {
            isPresented = true
        } label: {
            label
        }
        .sheet(isPresented: $isPresented) {
            content
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    @ViewBuilder private var content: some View {
        if let url = url {
            SafariView(url)
        } else {
            Text("Error: Invalid URL")
        }
    }
}

struct SafariButton_Previews: PreviewProvider {
    static var previews: some View {
        SafariButton(url: URL(string: "https://google.com")!) {
            Text("google.com")
        }
    }
}
