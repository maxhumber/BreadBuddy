import SwiftUI

struct Footer: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    @Environment(\.editMode) private var editMode
    
    // extract
    var footerMode: FooterMode {
        if editMode?.wrappedValue == .active {
            return .edit
        }
        if viewModel.recipe.isActive {
            return .active
        }
        return .display
    }
    
    enum FooterMode {
        case display
        case edit
        case active
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Color.clear.fixedSize(horizontal: false, vertical: true)
                leadingButton
            }
            ZStack {
                Color.clear.fixedSize(horizontal: false, vertical: true)
                trailingButton
            }
        }
        .foregroundColor(.black)
        .padding()
        .background(.green.opacity(0.2)) // debug
    }
    
    @ViewBuilder private var leadingButton: some View {
        switch footerMode {
        case .display: displayLeadingButton
        case .edit: editLeadingButton
        case .active: activeLeadingButton
        }
    }
    
    private var displayLeadingButton: some View {
        Button {
            viewModel.recipe.isActive = true
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "clock")
                    .font(.title2)
                Text("Start")
                    .font(.body)
            }
        }
    }
    
    private var editLeadingButton: some View {
        Button {
            
        } label: {
            VStack(spacing: 10) {
                Text("6:00 pm")
                    .font(.title2)
                Text("Friday")
                    .font(.body)
            }
        }
    }
    
    private var activeLeadingButton: some View {
        Button {
            viewModel.recipe.isActive = false
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "xmark.circle")
                    .font(.title2)
                Text("Cancel")
                    .font(.body)
            }
        }
    }
    
    @ViewBuilder private var trailingButton: some View {
        switch footerMode {
        case .display: displayTrailingButton
        case .edit: editTrailingButton
        case .active: activeTrailingButton
        }
    }
    
    private var displayTrailingButton: some View {
        Button {
            editMode?.wrappedValue = .active
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "pencil")
                    .font(.title2)
                Text("Edit")
                    .font(.body)
            }
        }
    }
    
    private var editTrailingButton: some View {
        Button {
            editMode?.wrappedValue = .inactive
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "square.and.arrow.down")
                    .font(.title2)
                Text("Save")
                    .font(.body)
            }
        }
    }
    
    private var activeTrailingButton: some View {
        Button {
            viewModel.recipe.isActive = false
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.title2)
                Text("Restart")
                    .font(.body)
            }
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
            Footer()
        }
        .navigationBarHidden(true)
        .dismissKeyboard()
        .environmentObject(viewModel)
        .onAppear(perform: viewModel.didAppear)
        .onChange(of: viewModel.recipe.timeEnd, perform: viewModel.didChange(timeEnd:))
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
