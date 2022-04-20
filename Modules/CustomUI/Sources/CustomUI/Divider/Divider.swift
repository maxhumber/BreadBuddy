import SwiftUI

public struct Divider: View {
    var label: String
    
    public init(_ label: String) {
        self.label = label
    }
    
    public var body: some View {
        HStack(spacing: 10) {
            line
            textLabel
            line
        }
    }
    
    private var textLabel: some View {
        Text(label)
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
            Divider("Bar")
            Text("Baz")
            Spacer()
        }
    }
}
