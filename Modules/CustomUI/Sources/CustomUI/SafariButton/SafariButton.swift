import SwiftUI

public struct SafariButton<Label: View>: View {
    var url: URL
    var label: Label
    @State private var isPresented = false
    
    public init(url: () -> URL, @ViewBuilder label: () -> Label) {
        self.url = url()
        self.label = label()
    }
    
    public var body: some View {
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

struct SafariButton_Previews: PreviewProvider {
    static var previews: some View {
        SafariButton {
            URL(string: "https://google.com")!
        } label: {
            Text("google.com")
        }
    }
}
