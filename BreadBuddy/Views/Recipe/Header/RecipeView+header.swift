import CustomUI
import SwiftUI

extension RecipeView {
    var header: some View {
        HStack(spacing: 0) {
            leadingButton
            nameField
            trailingButton
        }
        .foregroundColor(.primary)
        .padding()
    }
    
    @ViewBuilder private var leadingButton: some View {
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
    
    @ViewBuilder private var trailingButton: some View {
        switch viewModel.mode {
        case .display, .active:
            viewLinkButton
        case .edit:
            addLinkButton
        }
    }
    
    private var viewLinkButton: some View {
        SafariButton(url: viewModel.headerRecipeURL) {
            Image(systemName: "link")
        }
        .disabled(viewModel.headerLinkButtonIsDisabled)
    }
    
    private var addLinkButton: some View {
        Button {
            viewModel.headerLinkButtonAction()
        } label: {
            Image(systemName: "link.badge.plus")
        }
        .alert(isPresented: $viewModel.urlTextAlertIsPresented) {
            AlertInput(title: "Recipe URL", placeholder: "URL", text: $viewModel.recipe.link)
        }
    }
}

struct RecipeView_Header_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.preview, mode: .active, database: .preview)
    }
}
