import SwiftUI

struct Divider: View {
    var label: String
    
    init(_ label: String) {
        self.label = label
    }
    
    var body: some View {
        HStack(spacing: 10) {
            line
            textLabel
            line
        }
        .foregroundColor(.gray)
    }
    
    private var textLabel: some View {
        Text(label)
            .font(.caption)
    }
    
    private var line: some View {
        Rectangle()
            .frame(height: 1)
            .opacity(0.5)
    }
}

struct Divider_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .preview)
    }
}
