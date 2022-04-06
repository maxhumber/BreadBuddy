import SwiftUI

struct TimeView: View {
    @Environment(\.editMode) private var editMode
    @StateObject var viewModel: ViewModel
    
    init(recipe: String = "", date: Date? = nil, steps: [Step] = [Step]()) {
        let viewModel = ViewModel(recipe: recipe, date: date, steps: steps)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
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
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach($viewModel.steps) { $step in
                        Row(label: $step.description, value: $step.timeValue, unit: $step.timeUnit, date: $step.date) {
                            viewModel.refresh()
                        }
                    }
                    Button {
                        viewModel.add()
                    } label: {
                        Text("Add")
                    }
                    .buttonStyle(.bordered)
                    .opacity(isEditing ? 1 : 0)
                }
            }
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
                .disabled(!isEditing)
                .fixedSize()
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder()
                        .foregroundColor(.gray.opacity(0.25))
                        .if(!isEditing) { $0.opacity(0) }
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
