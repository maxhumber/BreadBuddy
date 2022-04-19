import SwiftUI

public struct StealthDatePicker<Label: View>: View {
    @Binding var date: Date
    var displayedComponent: DatePickerComponents
    var alignment: Alignment
    var label: Label
    
    public init(date: Binding<Date>, displayedComponent: DatePickerComponents = .date, alignment: Alignment = .center, @ViewBuilder label: () -> Label) {
        self._date = date
        self.displayedComponent = displayedComponent
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
            .opacity(0.0101)
    }
}

//struct DatePickerField_Previews: PreviewProvider {
//    static var previews: some View {
//        Preview()
//    }
//
//    struct Preview: View {
//        @State var date = Date()
//
//        var body: some View {
//            VStack(alignment: .center, spacing: 0) {
//                StealthDatePicker(date: $date, displayedComponent: .hourAndMinute, alignment: .bottom)
//                    .background(Rectangle().strokeBorder().foregroundColor(.red))
//                StealthDatePicker(date: $date, alignment: .center)
//                    .background(Rectangle().strokeBorder().foregroundColor(.red))
//                    .font(.caption)
//            }
//        }
//    }
//}
