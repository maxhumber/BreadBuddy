import Combine
import SwiftUI

struct RecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.editMode) private var editMode
    @StateObject var viewModel: RecipeViewModel

    init(date: Date? = nil, recipe: Recipe = .init(), database: Database = .shared) {
        let viewModel = RecipeViewModel(date: date, recipe: recipe)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
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
            .disabled(recipeNameIsDisabled)
    }
    
    private var recipeNameIsDisabled: Bool {
        editMode?.wrappedValue == .inactive
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
            viewModel.backAction {
                dismiss()
            }
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
                    StepView(for: step, in: viewModel.recipe)
                }
                newStepRow
            }
            .padding(.horizontal, 5)
        }
    }
    
    private var newStepRow: some View {
        StepView(for: viewModel.newStep, in: viewModel.recipe)
            .opacity(newStepRowOpacity)
    }
    
    private var newStepRowOpacity: Double {
        editMode?.wrappedValue == .active ? 1 : 0
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
        DatePickerField(date: $viewModel.date, displayedComponent: .hourAndMinute, alignment: .bottomTrailing)
    }
    
    private var weekdayPicker: some View {
        DatePickerField(date: $viewModel.date, displayedComponent: .date, alignment: .topTrailing)
            .font(.caption)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    struct Preview: View {
        var recipe: Recipe = .preview
        var date: Date = Date().withAdded(hours: 6)

        var body: some View {
            RecipeView(date: date, recipe: recipe)
        }
    }
}
