import CustomUI
import SwiftUI

extension RecipeView {
    var header: some View {
        HStack(spacing: 0) {
            leadingButton
            nameField
            trailingButton
        }
        .padding()
    }
    
    @ViewBuilder private var leadingButton: some View {
        Button {
            dismiss()
        } label: {
            ZStack {
                Image(systemName: "link.badge.plus").opacity(0)
                Image(systemName: "chevron.left")
            }
        }
        .opacity(viewModel.headerBackButtonIsDisplayed ? 1 : 0)
        .foregroundColor(.accent1)
    }
    
    private var nameField: some View {
        TextField("Recipe name", text: $viewModel.recipe.name)
            .font(.body)
            .foregroundColor(.text1)
            .underscore(hidden: viewModel.headerNameFieldUnderscoreIsHidden)
            .foregroundColor(.accent2)
            .multilineTextAlignment(.center)
            .disabled(viewModel.headerNameFieldIsDisabled)
            .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder private var trailingButton: some View {
        switch viewModel.mode {
        case .plan, .make:
            viewLinkButton
        case .edit:
            addLinkButton
        }
    }
    
    private var viewLinkButton: some View {
        SafariButton(url: viewModel.headerRecipeURL) {
            ZStack {
                Image(systemName: "link.badge.plus").opacity(0)
                Image(systemName: "link")
            }
        }
        .disabled(viewModel.headerLinkButtonIsDisabled)
        .foregroundColor(viewModel.headerLinkButtonIsDisabled ? .accent2 : .accent1)
        .opacity(viewModel.headerViewLinkButtonIsDisplayed ? 0 : 1)
    }
    
    private var addLinkButton: some View {
        InputtingButton {
            AlertInput(
                title: "Recipe URL",
                placeholder: "URL",
                text: $viewModel.recipe.link
            )
        } label: {
            Image(systemName: "link.badge.plus")
        }
        .foregroundColor(.accent1)
    }
}

struct RecipeView_Header_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .plan, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.preview, mode: .make, database: .preview)
    }
}
