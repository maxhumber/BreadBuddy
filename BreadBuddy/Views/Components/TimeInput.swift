import Combine
import SwiftUI

struct TimeInput: View {
    @Binding var value: Double
    @Binding var unit: TimeUnit
    var onCommit: (() -> ())? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            numberField
            menu
        }
    }
    
    private var numberField: some View {
        TextField("", value: $value, formatter: formatter) {
            onCommit?()
        }
        .fixedSize(horizontal: true, vertical: true)
        .keyboardType(.numberPad)
        .multilineTextAlignment(.center)
    }
    
    private var menu: some View {
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
                Text("XXXXXXX").opacity(0)
                Text(unit.label(for: value))
                    .animation(nil, value: UUID())
            }
            .font(.caption2)
        }
        .onChange(of: unit) { _ in
            onCommit?()
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
                .background(Rectangle().strokeBorder().foregroundColor(.red))
        }
    }
}
