import SwiftUI

public struct StealthNavigationLink<Destination: View, Label: View>: View {
    var destination: Destination
    var label: Label
    
    public init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination()
        self.label = label()
    }
    
    public var body: some View {
        ZStack {
            NavigationLink(destination: destination) {
                EmptyView()
            }
            .contentShape(Rectangle())
            label
        }
    }
}

struct StealthNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StealthList {
                StealthNavigationLink {
                    Text("Hey")
                } label: {
                    Text("Toggle")
                }
            }
        }
    }
}
