import SwiftUI

public struct InputtingButton<Label: View>: View {
    @State private var isPresented = false
    private var input: () -> AlertInput
    private var label: Label
    
    public init(input: @escaping () -> AlertInput, @ViewBuilder label: () -> Label) {
        self.input = input
        self.label = label()
    }
    
    public var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            label
        }
        .alert(isPresented: $isPresented) {
            input()
        }
    }
}

struct InputtingButton_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var text: String?
        
        var body: some View {
            InputtingButton {
                AlertInput(title: "Enter", placeholder: "Something", text: $text)
            } label: {
                Text("Toggle")
            }
        }
    }
}
