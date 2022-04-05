import SwiftUI

struct TimeView: View {
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
        VStack(spacing: 10) {
            header
            VStack {
                ScrollView(showsIndicators: false) {
                    ForEach($viewModel.steps) { $step in
                        Row(label: $step.description, value: $step.timeValue, unit: $step.timeUnit, date: $step.date) {
                            viewModel.refresh()
                        }
                        .padding(.vertical)
                    }
                    Button {
                        viewModel.add()
                    } label: {
                        Text("Add")
                    }
                    .buttonStyle(.bordered)
                }
            }
            Spacer()
            HStack {
                Text("Finish")
                Spacer()
                VStack(alignment: .trailing, spacing: 5) {
                    DatePickerField(date: $viewModel.date, displayedComponent: .hourAndMinute, alignment: .bottomTrailing)
                    DatePickerField(date: $viewModel.date, displayedComponent: .date, alignment: .topTrailing)
                        .font(.caption)
                }
                .foregroundColor(.blue)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private var header: some View {
        ZStack {
            TextField("Recipe name", text: $viewModel.recipe)
                .fixedSize()
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder()
                        .foregroundColor(.gray.opacity(0.25))
                )
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            EditButton()
                .frame(maxWidth: .infinity, alignment: .trailing)
            Button {
                
            } label: {
                Image(systemName: "chevron.left")
            }
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        var recipe = "Maggie's Baguette"
        var date: Date = Date().withAdded(hours: 6)
        var steps: [Step] = [
            Step(description: "Poolish", timeValue: 30, timeUnit: .minutes),
            Step(description: "Mix Dough", timeValue: 15, timeUnit: .minutes),
            Step(description: "Bulk rise", timeValue: 8, timeUnit: .hours),
            Step(description: "Shape", timeValue: 15, timeUnit: .minutes),
            Step(description: "Proof", timeValue: 30, timeUnit: .minutes),
            Step(description: "Bake", timeValue: 60, timeUnit: .minutes)
        ]
        
        var body: some View {
            TimeView(recipe: recipe, date: date, steps: steps)
        }
    }
}
