import BreadKit
import SwiftUI

struct Divider: View {
    var group: StepGroup
    
    init(_ group: StepGroup) {
        self.group = group
    }
    
    var body: some View {
        HStack(spacing: 10) {
            line
            label
            line
        }
        .foregroundColor(.gray)
        .padding(.horizontal)
    }
    
    private var label: some View {
        Text(group.label)
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
