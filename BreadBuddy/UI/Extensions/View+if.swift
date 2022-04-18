import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func `if`<IfContent: View, ElseContent: View>(_ condition: Bool, if ifTransform: (Self) -> IfContent, else elseTransform: (Self) -> ElseContent) -> some View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }
}
