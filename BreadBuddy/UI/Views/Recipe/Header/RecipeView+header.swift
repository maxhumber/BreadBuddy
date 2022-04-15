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
            viewModel.headerBackButtonAction()
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
            viewModel.headerBackButtonAction()
        } label: {
            Image(systemName: "trash")
                .foregroundColor(.red)
        }
        .opacity(viewModel.headerDeleteButtonIsDisplayed ? 1 : 0)
    }
}

struct RecipeView_Header_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: .preview, mode: .display)
        RecipeView(recipe: .preview, mode: .edit)
        RecipeView(recipe: .preview, mode: .active)
    }
}
