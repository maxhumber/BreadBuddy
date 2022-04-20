import SwiftUI

public struct Divider<Label: View>: View {
    var spacing: Double
    var label: Label
    
    public init(spacing: Double = 10, @ViewBuilder label: () -> Label) {
        self.spacing = spacing
        self.label = label()
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            line
            label
            line
        }
    }
    
    private var line: some View {
        Rectangle()
            .frame(height: 1)
    }
}

struct Divider_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Foo")
            Divider {
                Text("Bar")
            }
            Text("Baz")
            Spacer()
        }
    }
}
