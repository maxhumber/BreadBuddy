import SwiftUI

struct CustomEditButton: View {
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 10) {
                Image(systemName: editMode?.wrappedValue == .active ? "square.and.arrow.down" : "pencil")
                Text(editMode?.wrappedValue == .active ? "Save" : "Edit")
                    .font(.caption)
            }
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
            button1
                .frame(maxWidth: .infinity)
            CustomEditButton()
                .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder private var button1: some View {
        if editMode?.wrappedValue == .active {
            pickers
        } else {
            VStack(spacing: 10) {
                Image(systemName: "clock")
                    .font(.title3)
                Text("Start")
                    .font(.caption)
            }
        }
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
            Button {
                dismiss()
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .opacity(editMode?.wrappedValue == .active ? 1 : 0)
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
        .opacity(editMode?.wrappedValue == .active ? 0 : 1)
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
    
    private var pickers: some View {
        VStack(alignment: .center, spacing: 5) {
            timePicker
            weekdayPicker
        }
        .foregroundColor(.blue)
    }
    
    private var timePicker: some View {
        DatePickerField(date: $viewModel.recipe.timeEnd, displayedComponent: .hourAndMinute, alignment: .bottom)
    }
    
    #warning("bug on these pickers for padding")
    private var weekdayPicker: some View {
        DatePickerField(date: $viewModel.recipe.timeEnd, displayedComponent: .date, alignment: .top)
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
