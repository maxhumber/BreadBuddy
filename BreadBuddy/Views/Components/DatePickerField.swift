import SwiftUI

extension Date {
    func weekday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    func time() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }
}

struct DatePickerField: View {
    @Binding var date: Date
    var displayedComponent: DatePickerComponents = .date
    
    var body: some View {
        DatePicker("", selection: $date, displayedComponents: displayedComponent)
            .labelsHidden()
            .allowsHitTesting(true)
            .opacity(0.0101)
            .background(Text(label))
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
            VStack {
                DatePickerField(date: $date)
                DatePickerField(date: $date, displayedComponent: .hourAndMinute)
            }
        }
    }
}
