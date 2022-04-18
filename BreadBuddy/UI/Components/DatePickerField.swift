import SwiftUI

struct DatePickerField: View {
    @Binding var date: Date
    var displayedComponent: DatePickerComponents
    var alignment: Alignment
    var underline: Bool
    
    init(date: Binding<Date>, displayedComponent: DatePickerComponents = .date, alignment: Alignment = .center, underline: Bool = false) {
        self._date = date
        self.displayedComponent = displayedComponent
        self.alignment = alignment
        self.underline = underline
    }
    
    var body: some View {
        ZStack(alignment: alignment) {
            Text(label)
                .if(underline) { $0.underline() }
            picker
        }
    }
    
    private var picker: some View {
        DatePicker("", selection: $date, displayedComponents: displayedComponent)
            .labelsHidden()
            .opacity(0.0101)
    }
    
    private var label: String {
        switch displayedComponent {
        case .date:
            return date.dayOfWeek()
        case .hourAndMinute:
            return date.clocktime
        default:
            return ""
        }
    }
}

struct DatePickerField_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var date = Date()
        
        var body: some View {
            VStack(alignment: .center, spacing: 0) {
                DatePickerField(date: $date, displayedComponent: .hourAndMinute, alignment: .bottom)
                    .background(Rectangle().strokeBorder().foregroundColor(.red))
                DatePickerField(date: $date, alignment: .center)
                    .background(Rectangle().strokeBorder().foregroundColor(.red))
                    .font(.caption)
            }
        }
    }
}
