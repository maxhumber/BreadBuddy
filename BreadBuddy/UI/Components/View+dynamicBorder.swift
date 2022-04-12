import SwiftUI

extension View {
    func dynamicBorder() -> some View {
        self.modifier(DynamicBorder())
    }
}

fileprivate struct DynamicBorder: ViewModifier {
    @Environment(\.editMode) private var editMode

    func body(content: Content) -> some View {
        content
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder()
                    .foregroundColor(.gray.opacity(0.25))
                    .opacity(borderOpacity)
            )
    }
    
    private var borderOpacity: Double {
        isEditing ? 1 : 0
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
}
