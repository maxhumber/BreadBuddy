import Combine
import SwiftUI

struct TimeInput: View {
    @Binding var value: Double
    @Binding var unit: TimeUnit
    var onChange: (() -> ())? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            numberField
            menu
        }
    }
    
    private var numberField: some View {
        ZStack {
            Text("000").opacity(0)
            TextField("", value: $value, formatter: formatter) {
                onChange?()
            }
            .fixedSize(horizontal: true, vertical: true)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
        }
        .if(value == 0) {
            $0.foregroundColor(.gray.opacity(0.5))
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder()
                .foregroundColor(.gray.opacity(0.25))
        )
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
        .contentShape(Rectangle())
        .onChange(of: unit) { _ in
            onChange?()
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
            VStack {
                TimeInput(value: $value, unit: $unit)
                    .background(Rectangle().strokeBorder().foregroundColor(.red))
                TimeInput(value: .constant(0), unit: .constant(.minute))
            }
        }
    }
}
