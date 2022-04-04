import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                viewModel.add()
            } label: {
                Text("Add step")
            }
            VStack(spacing: 20) {
                ForEach($viewModel.steps) { $step in
                    Row(label: $step.label, value: $step.timeValue, unit: $step.timeUnit, date: $step.date)
                }
//                Row(label: .constant(""), value: .constant(0), unit: .constant(.minute), date: .constant(nil))
            }
            Spacer()
            DatePicker(selection: $viewModel.time, displayedComponents: .date) {
                Text("Eat at:")
            }
            DatePicker(selection: $viewModel.time, displayedComponents: .hourAndMinute) {
                Text("Eat at:")
            }
            DatePicker("Due Date", selection: $viewModel.time, displayedComponents: .date)
                .labelsHidden()
                .allowsHitTesting(true)
                .opacity(0.0101)
                .background(
                    Text(dayFormatter.string(from: viewModel.time))
                        .foregroundColor(.blue)
                )
            Button {
                viewModel.refresh()
            } label: {
                Text("refresh")
            }
        }
        .padding()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
