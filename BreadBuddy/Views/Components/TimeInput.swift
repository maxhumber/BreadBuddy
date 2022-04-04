import Combine
import SwiftUI

enum TimeUnit: String, CaseIterable, Identifiable {
    case minute = "Minute"
    case hour = "Hour"
    case day = "Day"
    
    var id: String {
        rawValue
    }
    
    func label(for value: Double) -> String {
        value == 1 ? rawValue : rawValue + "s"
    }
}

struct TimeInput: View {
    @Binding var value: Double
    @Binding var unit: TimeUnit
    
    var body: some View {
        VStack(spacing: 0) {
            numberField()
            menu()
        }
    }
    
    private func numberField() -> some View {
        TextField("", value: $value, formatter: formatter)
            .fixedSize(horizontal: true, vertical: true)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
    }
    
    private func menu() -> some View {
        Menu {
            ForEach(TimeUnit.allCases) { unit in
                Button {
                    self.unit = unit
                } label: {
                    Text(unit.rawValue)
                }
            }
        } label: {
            ZStack {
                Text("minutes").opacity(0)
                Text(unit.label(for: value))
                    .animation(nil, value: UUID())
            }
            .font(.caption2)
        }
    }
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}

struct NumberInput_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var value = 2.0
        @State var unit = TimeUnit.minute
        
        var body: some View {
            TimeInput(value: $value, unit: $unit)
                .background(Color.red)
        }
    }
}
