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
            ScrollView {
                VStack(spacing: 20) {
                    ForEach($viewModel.steps) { $step in
                        Row(label: $step.label, value: $step.timeValue, unit: $step.timeUnit, date: $step.date)
                    }
                }
            }
            Spacer()
            HStack {
                Text("I want to eat at:")
                Spacer()
                VStack(alignment: .trailing, spacing: 0) {
                    DatePickerField(date: $viewModel.date, displayedComponent: .hourAndMinute, alignment: .bottomTrailing)
                        .font(.title3)
                    DatePickerField(date: $viewModel.date, displayedComponent: .date, alignment: .topTrailing)
                        .font(.caption)
                }
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
