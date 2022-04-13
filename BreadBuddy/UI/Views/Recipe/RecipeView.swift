import SwiftUI

struct RecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.editMode) private var editMode
    @StateObject var viewModel: RecipeViewModel

    init(recipe: Recipe = .init(), database: Database = .shared) {
        let viewModel = RecipeViewModel(recipe: recipe, database: database)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .environmentObject(viewModel)
            .onAppear(perform: viewModel.didAppear)
            .onChange(of: viewModel.recipe.timeEnd, perform: viewModel.didChange(timeEnd:))
    }

    private var content: some View {
        VStack(spacing: 10) {
            header
            steps
            footer
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .dismissKeyboard()
    }

    private var header: some View {
        ZStack {
            recipeName
            headerButtons
        }
        .padding()
    }
    
    private var recipeName: some View {
        TextField("Recipe name", text: $viewModel.recipe.name)
            .multilineTextAlignment(.center)
            .fixedSize()
            .dynamicBorder()
            .disabled(editMode?.wrappedValue == .inactive)
    }
    
    private var headerButtons: some View {
        HStack {
            backButton
            Spacer()
            EditButton()
        }
    }
    
    private var backButton: some View {
        Button {
            viewModel.back { dismiss() }
        } label: {
            Image(systemName: "chevron.left")
                .contentShape(Rectangle())
        }
        .alert(isPresented: $viewModel.dimissAlertIsDisplayed) {
            dismissAlert
        }
    }
    
    private var dismissAlert: Alert {
        Alert(
            title: Text("Missing Name"),
            message: Text("Recipe must have a name in order to continue"),
            dismissButton: .default(Text("Okay"))
        )
    }

    private var steps: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach($viewModel.recipe.steps) { $step in
                    InnerStepRow(for: $step)
                }
                NewStepRow(for: $viewModel.newStep)
            }
            .padding(.horizontal, 5)
        }
    }

    private var footer: some View {
        HStack {
            Text("Finish")
            Spacer()
            pickers
        }
        .padding(.horizontal)
    }

    private var pickers: some View {
        VStack(alignment: .trailing, spacing: 5) {
            timePicker
            weekdayPicker
        }
        .foregroundColor(.blue)
    }
    
    private var timePicker: some View {
        DatePickerField(date: $viewModel.recipe.timeEnd, displayedComponent: .hourAndMinute, alignment: .bottomTrailing)
    }
    
    private var weekdayPicker: some View {
        DatePickerField(date: $viewModel.recipe.timeEnd, displayedComponent: .date, alignment: .topTrailing)
            .font(.caption)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    struct Preview: View {
        var recipe: Recipe = .preview

        var body: some View {
            RecipeView(recipe: recipe)
        }
    }
}
