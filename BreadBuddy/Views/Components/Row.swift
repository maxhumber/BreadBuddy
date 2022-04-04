import SwiftUI

public struct Row: View {
    @Binding var label: String
    @Binding var value: Double
    @Binding var unit: TimeUnit
    @Binding var date: Date?
    
    public var body: some View {
        HStack(alignment: .top, spacing: 20) {
            TextField("Add a step", text: $label)
            Spacer()
            TimeInput(value: $value, unit: $unit)
            timeStack()
        }
    }
    
    private func timeStack() -> some View {
        ZStack {
            Text("XX:XX XX").hidden()
            VStack(alignment: .trailing) {
                Text(timeFormatter.string(from: unwrappedDate))
                Text(dayFormatter.string(from: unwrappedDate))
                    .font(.caption2)
            }
            .opacity(timeStackOpacity)
        }
    }
    
    private var unwrappedDate: Date {
        date ?? Date()
    }
    
    private var timeStackOpacity: Double {
        date == nil ? 0 : 1
    }
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var label = "Mix Ingredients"
        @State var value = 0.5
        @State var unit: TimeUnit = .minute
        @State var date: Date? = Date()
        
        var body: some View {
            VStack(spacing: 20) {
                Row(label: $label, value: $value, unit: $unit, date: $date)
            }
            .padding()
        }
    }
}
