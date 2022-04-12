import SwiftUI

struct SkeleText: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text).opacity(0)
    }
}
