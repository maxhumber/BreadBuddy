import SwiftUI

struct NumberField: View {
    @FocusState private var isFocused: Bool
    @Binding var value: Double
    var onCommit: (() -> ())? = nil
    
    var body: some View {
        TextField("", value: $value, formatter: .number, onCommit: {
            print("ON COMMIT")
            onCommit?()
        })
        .focused($isFocused)
        .onChange(of: isFocused) { isFocused in
            if !isFocused {
                print("ON FOCUS LOST")
                onCommit?()
            }
        }
        .multilineTextAlignment(.center)
        .fixedSize(horizontal: true, vertical: true)
        .keyboardType(.numberPad)
        .if(value == 0) {
            $0.foregroundColor(.gray.opacity(0.5))
        }
    }
}

struct NumberField_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var value = 2.0
        
        var body: some View {
            VStack {
                NumberField(value: $value)
                    .background(
                        Rectangle().strokeBorder().foregroundColor(.red)
                    )
                NumberField(value: .constant(0))
            }
        }
    }
}
