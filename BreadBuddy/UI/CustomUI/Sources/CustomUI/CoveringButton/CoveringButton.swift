import SwiftUI

public struct CoveringButton<Destination: View, Label: View>: View {
    @State private var isPresented = false
    private var destination: Destination
    private var label: Label
    private var onDismiss: (() -> ())?

    public init(@ViewBuilder destination: () -> Destination, onDismiss: (() -> ())? = nil, @ViewBuilder label: () -> Label) {
        self.destination = destination()
        self.onDismiss = onDismiss
        self.label = label()
    }
    
    public var body: some View {
        Button {
            isPresented = true
        } label: {
            label
        }
        .fullScreenCover(isPresented: $isPresented) {
            onDismiss?()
        } content: {
            destination
        }
    }
}

struct CoveringButton_Previews: PreviewProvider {
    static var previews: some View {
        CoveringButton {
            DestinationView()
        } onDismiss: {
            print("didDismiss")
        } label: {
            Image(systemName: "chevron.up")
        }
    }
    
    struct DestinationView: View {
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            VStack {
                Text("Destination View")
                Button {
                    dismiss()
                } label: {
                    Text("Dismiss")
                }
            }
        }
    }
}
