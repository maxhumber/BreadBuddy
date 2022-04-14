import SwiftUI

struct CustomEditButton: View {
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(editMode?.wrappedValue == .active ? "Done" : "Edit")
        }
    }
    
    private func action() {
        switch editMode?.wrappedValue {
        case .active:
            editMode?.wrappedValue = .inactive
        case .inactive:
            editMode?.wrappedValue = .active
        default:
            break
        }
    }
}

struct RecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.editMode) private var editMode
    @StateObject var viewModel: RecipeViewModel
    
    init(recipe: Recipe = .init(), database: Database = .shared) {
        let viewModel = RecipeViewModel(recipe: recipe, database: database)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            header
            content
            footer2
        }
        .navigationBarHidden(true)
        .dismissKeyboard()
        .environmentObject(viewModel)
        .onAppear(perform: viewModel.didAppear)
        .onChange(of: viewModel.recipe.timeEnd, perform: viewModel.didChange(timeEnd:))
    }
    
    #warning("Need to properly space this")
    private var footer2: some View {
        HStack {
            VStack(spacing: 10) {
                Image(systemName: "clock")
                    .font(.title3)
                Text("Start")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            VStack(spacing: 10) {
                Image(systemName: "pencil")
                    .font(.title3)
                Text("Edit")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
    
    private var header: some View {
        ZStack {
            recipeName
            headerButtons
        }
        .padding()
    }
    
    @ViewBuilder private var recipeName: some View {
        ZStack {
            SkeleText("XXXXXXXXXXX")
            TextField("Recipe name", text: $viewModel.recipe.name)
                .multilineTextAlignment(.center)
        }
        .font(.body)
        .if(editMode?.wrappedValue == .active) {
            $0.lined()
        } else: {
            $0.disabled(true)
        }
        .fixedSize()
    }
    
    private var headerButtons: some View {
        HStack {
            backButton
            Spacer()
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
    
    @ViewBuilder private var content: some View {
        if editMode?.wrappedValue == .active {
            EditContent(recipe: $viewModel.recipe)
        } else {
            DisplayContent(recipe: viewModel.recipe)
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

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: .preview)
        RecipeView(recipe: .preview)
            .environment(\.editMode, .constant(.active))
    }
}
