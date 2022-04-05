import SwiftUI

public struct Row: View {
    @Binding var label: String
    @Binding var value: Double
    @Binding var unit: TimeUnit
    @Binding var date: Date?
    var onCommit: (() -> ())? = nil
    
    public var body: some View {
        HStack(alignment: .top, spacing: 20) {
            TextField("Description", text: $label) {
                onCommit?()
            }
            Spacer()
            TimeInput(value: $value, unit: $unit) {
                onCommit?()
            }
            timeStack
        }
    }
    
    private var timeStack: some View {
        ZStack {
            Text("XX:XX XX").hidden()
            VStack(alignment: .trailing) {
                Text(unwrappedDate.time())
                Text(unwrappedDate.weekday())
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
