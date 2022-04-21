import SwiftUI

extension View {
    public func alert(isPresented: Binding<Bool>, input: () -> AlertInput) -> some View {
        ZStack {
            if isPresented.wrappedValue {
                AlertInputWrapper(isPresented: isPresented, alertInput: input())
                    .fixedSize()
            }
            self
        }
    }
}

struct AlertInput_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var alertIsPresented = false
        @State var text: String? = ""
        
        var body: some View {
            VStack {
                Text(text ?? "Nothing")
                Text("Demo")
                Button {
                    alertIsPresented = true
                } label: {
                    Text("Toggle Alert")
                }
            }
            .alert(isPresented: $alertIsPresented) {
                AlertInput(title: "Enter", placeholder: "Something", text: $text)
            }
        }
    }
}
