import SwiftUI

extension View {
    func dynamicBorder() -> some View {
        modifier(DynamicBorder())
    }
}

struct DynamicBorder: ViewModifier {
    @Environment(\.editMode) private var editMode
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    func body(content: Content) -> some View {
        content
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder()
                    .foregroundColor(.gray.opacity(0.25))
                    .if(!isEditing) {
                        $0.opacity(0)
                    }
            )
    }
}
