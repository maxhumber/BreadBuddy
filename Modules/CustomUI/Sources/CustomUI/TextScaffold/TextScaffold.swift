import SwiftUI

public struct TextScaffold: View {
    var text: String
    
    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text).opacity(0)
    }
}
