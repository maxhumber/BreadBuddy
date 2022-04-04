import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        content()
            .onChange(of: viewModel.date) { _ in
                viewModel.refresh()
            }
    }
    
    private func content() -> some View {
        VStack(spacing: 20) {
            header()
            ScrollView {
                VStack(spacing: 20) {
                    ForEach($viewModel.steps) { $step in
                        Row(label: $step.label, value: $step.timeValue, unit: $step.timeUnit, date: $step.date) {
                            viewModel.refresh()
                        }
                    }
                    Button {
                        viewModel.add()
                    } label: {
                        Text("Add")
                    }
                }
            }
            Spacer()
            HStack {
                Text("I want to eat at:")
                Spacer()
                VStack(alignment: .trailing, spacing: 0) {
                    DatePickerField(date: $viewModel.date, displayedComponent: .hourAndMinute, alignment: .bottomTrailing)
                    DatePickerField(date: $viewModel.date, displayedComponent: .date, alignment: .topTrailing)
                        .font(.caption)
                }
                .foregroundColor(.blue)
            }
        }
        .padding()
    }
    
    private func header() -> some View {
        HStack {
            Text("Maggie's Baguette")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
