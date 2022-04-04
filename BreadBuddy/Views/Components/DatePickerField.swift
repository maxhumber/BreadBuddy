import SwiftUI

struct DatePickerField: View {
    @Binding var date: Date
    var displayedComponent: DatePickerComponents = .date
    var alignment: Alignment = .center
    
    var body: some View {
        ZStack(alignment: alignment) {
            Text(label)
            DatePicker("", selection: $date, displayedComponents: displayedComponent)
                .labelsHidden()
                .opacity(0.0101)
        }
    }
    
    private var label: String {
        switch displayedComponent {
        case .date: return date.weekday()
        case .hourAndMinute: return date.time()
        default: return ""
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
            VStack(alignment: .trailing,spacing: 0) {
                DatePickerField(date: $date, displayedComponent: .hourAndMinute, alignment: .bottomTrailing)
                    .background(Rectangle().strokeBorder().foregroundColor(.red))
                DatePickerField(date: $date, alignment: .topTrailing)
                    .background(Rectangle().strokeBorder().foregroundColor(.red))
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
