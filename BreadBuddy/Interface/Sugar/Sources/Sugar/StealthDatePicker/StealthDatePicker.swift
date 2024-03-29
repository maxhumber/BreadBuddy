import SwiftUI

public struct StealthDatePicker<Label: View>: View {
    @Binding var date: Date
    var displayedComponent: DatePickerComponents
    var alignment: Alignment
    var label: Label
    
    public init(_ displayedComponent: DatePickerComponents = .date, date: Binding<Date>, alignment: Alignment = .center, @ViewBuilder label: () -> Label) {
        self.displayedComponent = displayedComponent
        self._date = date
        self.alignment = alignment
        self.label = label()
    }
    
    public var body: some View {
        ZStack(alignment: alignment) {
            label
            picker
        }
    }
    
    private var picker: some View {
        DatePicker("", selection: $date, displayedComponents: displayedComponent)
            .labelsHidden()
            .opacity(0.02)
    }
}

struct StealthDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State private var date = Date()
        
        var body: some View {
            StealthDatePicker(.date, date: $date) {
                Image(systemName: "calendar")
            }
        }
    }
}
