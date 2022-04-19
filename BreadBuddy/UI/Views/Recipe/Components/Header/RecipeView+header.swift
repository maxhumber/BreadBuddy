import SwiftUI

extension RecipeView {
    var header: some View {
        ZStack {
            HStack(spacing: 0) {
                leadingButton
                nameField
                trailingButton
            }
            .padding()
            alertLayer
        }
    }
    
    private var alertLayer: some View {
        EmptyView()
            .alert(isPresented: $viewModel.urlTextAlertIsPresented) {
                TextAlert(title: "Recipe URL", placeholder: "URL", accept: "Save") { newURL in
                    print("Callback \(newURL ?? "<cancel>")")
                }
            }
            .fixedSize()
    }
    
    private var leadingButton: some View {
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
    
    private var trailingButton: some View {
        Button {
            viewModel.headerLinkButtonAction()
        } label: {
            Image(systemName: "link")
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
        RecipeView(.preview, mode: .display, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.preview, mode: .active, database: .preview)
    }
}
