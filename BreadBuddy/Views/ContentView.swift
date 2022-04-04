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
                Row(label: .constant(""), value: .constant(0), unit: .constant(.minute), date: .constant(nil))
            }
            Spacer()
//            List($viewModel.steps) { $step in
//                Row(label: $step.label, value: $step.timeValue, unit: $step.timeUnit, date: $step.date)
//                    .listRowSeparator(.hidden)
//                    .listRowInsets(.init())
//                    .padding(.bottom, 20)
//            }
//            .listStyle(.plain)
            DatePicker(selection: $viewModel.time) {
                Text("Eat at:")
            }
            Button {
                viewModel.refresh()
            } label: {
                Text("refresh")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
