import SwiftUI

extension RecipeView {
    var header: some View {
        HStack(spacing: 0) {
            backButton
            nameField
            deleteButton
        }
        .padding()
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
        .opacity(viewModel.headerBackButtonIsDisplayed ? 1 : 0)
    }
    
    private var nameField: some View {
        TextField("Recipe name", text: $viewModel.recipe.name)
            .multilineTextAlignment(.center)
            .disabled(viewModel.headerNameFieldIsDisabled)
            .underscore(hidden: viewModel.headerNameFieldUnderscoreIsHidden)
            .frame(maxWidth: .infinity)
    }
    
    private var deleteButton: some View {
        Button {
            viewModel.headerDeleteButtonAction()
        } label: {
            Image(systemName: "trash")
                .foregroundColor(.red)
        }
        .opacity(viewModel.headerDeleteButtonIsDisplayed ? 1 : 0)
        .alert(isPresented: $viewModel.deleteAlertIsPresented) {
            deleteAlert
        }
    }

    private var deleteAlert: Alert {
        Alert(
            title: Text("Delete Recipe"),
            message: Text("Are you sure you want to delete this recipe?"),
            primaryButton: .destructive(Text("Confirm")) {
                viewModel.alertDeleteAction()
                dismiss()
            },
            secondaryButton: .cancel()
        )
    }
}

struct RecipeView_Header_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .empty)
        RecipeView(.preview, mode: .edit, database: .empty)
        RecipeView(.preview, mode: .active, database: .empty)
    }
}
