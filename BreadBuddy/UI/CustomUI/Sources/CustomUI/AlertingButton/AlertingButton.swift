import SwiftUI

public struct AlertingButton<Label: View>: View {
    public var alert: () -> Alert
    @ViewBuilder public var label: Label
    @State private var alertIsPresented = false
    
    public init(alert: @escaping () -> Alert, @ViewBuilder label: () -> Label) {
        self.alert = alert
        self.label = label()
    }
    
    public var body: some View {
        Button {
            alertIsPresented.toggle()
        } label: {
            label
        }
        .alert(isPresented: $alertIsPresented) {
            alert()
        }
    }
}

struct AlertingButton_Previews: PreviewProvider {
    static var previews: some View {
        AlertingButton {
            Alert(
                title: Text("Dismiss"),
                message: Text("Are you sure?"),
                dismissButton: .default(Text("Confirm"))
            )
        } label: {
            Image(systemName: "xmark.circle")
        }
    }
}
