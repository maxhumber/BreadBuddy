import Combine
import SwiftUI

enum TimeUnit: String, CaseIterable, Identifiable {
    case minute
    case hour
    case day
    
    var id: String {
        rawValue
    }
}

struct Step2 {
    var duration: Double = 0
    var unit: TimeUnit = .minute
    
    var unitName: String {
        let maybePlural = duration == 1 ? "" : "s"
        return unit.rawValue + maybePlural
    }
}

struct TimeInput: View {
    @State var step = Step2()
    
    var body: some View {
        VStack {
            numberField()
            menu()
        }
    }
    
    private func numberField() -> some View {
        TextField("", value: $step.duration, formatter: formatter)
            .fixedSize(horizontal: true, vertical: true)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(.title)
    }
    
    private func menu() -> some View {
        Menu {
            options()
        } label: {
            label()
        }
    }
    
    private func options() -> some View {
        ForEach(TimeUnit.allCases) { unit in
            Button {
                step.unit = unit
            } label: {
                Text(unit.rawValue)
            }
        }
    }
    
    private func label() -> some View {
        ZStack {
            Text("minutes")
                .opacity(0)
            Text(step.unitName)
                .animation(nil, value: UUID())
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
        TimeInput()
            .background(Color.red)
    }
}
