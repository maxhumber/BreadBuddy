import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    init(recipe: String = "", date: Date? = nil, steps: [Step] = [Step]()) {
        let viewModel = ViewModel(recipe: recipe, date: date, steps: steps)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .dismissKeyboard()
            .onAppear {
                viewModel.refresh()
            }
            .onChange(of: viewModel.date) { _ in
                viewModel.refresh()
            }
    }
    
    private var content: some View {
        VStack(spacing: 20) {
            header
            List {
                ForEach($viewModel.steps) { $step in
                    Row(label: $step.description, value: $step.timeValue, unit: $step.timeUnit, date: $step.date) {
                        viewModel.refresh()
                    }
                    .padding(.vertical)
                }
                .onDelete(perform: viewModel.remove)
                .listRowSeparator(.hidden)
                .listRowInsets(.init())
                Button {
                    viewModel.add()
                } label: {
                    Text("Add")
                }
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .center)
                .buttonStyle(PlainButtonStyle())
                .listRowSeparator(.hidden)
                .listRowInsets(.init())
            }
            .listStyle(.plain)
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
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private var header: some View {
        ZStack {
            TextField("Recipe name", text: $viewModel.recipe)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            EditButton()
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        var recipe = "Maggie's Baguette"
        var date: Date = .init()
        var steps: [Step] = [
            Step(description: "Poolish", timeValue: 30, timeUnit: .minute),
            Step(description: "Mix Dough", timeValue: 15, timeUnit: .minute),
            Step(description: "Bulk rise", timeValue: 8, timeUnit: .hour),
            Step(description: "Shape", timeValue: 15, timeUnit: .minute),
            Step(description: "Proof", timeValue: 30, timeUnit: .minute),
            Step(description: "Bake", timeValue: 60, timeUnit: .minute)
        ]
        
        var body: some View {
            ContentView(recipe: recipe, date: date, steps: steps)
        }
    }
}
