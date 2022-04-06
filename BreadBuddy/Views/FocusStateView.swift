import SwiftUI

struct FocusStateView: View {
    enum Field {
        case text1
        case text2
    }
    
    @State var text1 = ""
    @State var text2 = ""
    @FocusState private var focusField: Field?

    var body: some View {
        VStack {
            HStack {
                TextField("Text 1", text: $text1)
                    .focused($focusField, equals: .text1)
                    .submitLabel(.next)
                    .padding()
                    .background(
                        Rectangle().strokeBorder().foregroundColor(.red)
                    )
                    .onSubmit {
                        print("didSubmit text1")
                        focusField = .text2
                    }
                TextField("Text 2", text: $text2)
                    .focused($focusField, equals: .text2)
                    .submitLabel(.done)
                    .padding()
                    .background(
                        Rectangle().strokeBorder().foregroundColor(.red)
                    )
                    .onSubmit {
                        print("didSubmit text2")
                        focusField = .none
                    }
            }
            .padding()
            .onChange(of: focusField) { focusField in
                print("focusField:", focusField)
            }
            Button {
                print("didTapButton")
            } label: {
                Text("Test Button")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onTapGesture {
            focusField = .none
        }
    }
}

struct FocusStateView_Previews: PreviewProvider {
    static var previews: some View {
        FocusStateView()
    }
}
