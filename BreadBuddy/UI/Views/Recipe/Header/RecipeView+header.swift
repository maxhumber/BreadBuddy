import CustomUI
import SwiftUI

extension RecipeView {
    var header: some View {
        HStack(spacing: 0) {
            leadingButton
            name
            trailingButton
        }
        .padding()
    }
    
    private var leadingButton: some View {
        ZStack {
            Image(systemName: "link.badge.plus")
                .opacity(0)
            switch viewModel.mode {
            case .plan: backButton
            case .make: backButton
            case .edit: deleteButton // need to be here? for cancel
            }
        }
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .contentShape(Rectangle())
        }
    }
    
    private var deleteButton: some View {
        AlertingButton {
            deleteAlert
        } label: {
            Image(systemName: "trash")
                .contentShape(Rectangle())
        }
    }
    
    private var name: some View {
        Group {
            switch viewModel.mode {
            case .plan: nameText
            case .make: nameText
            case .edit: nameField
            }
        }
        .font(.matter())
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }
    
    private var nameText: some View {
        Text(viewModel.recipe.name)
            .foregroundColor(.text1)
            .underscore(hidden: true)
            .onTapGesture { viewModel.edit() }
    }
    
    private var nameField: some View {
        TextField("Enter name", text: $viewModel.recipe.name)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .foregroundColor(.text1)
            .underscore()
            .foregroundColor(.accent2)
    }
    
    private var trailingButton: some View {
        ZStack {
            Image(systemName: "link.badge.plus")
                .opacity(0)
            switch viewModel.mode {
            case .plan: editButton
            case .make: viewLinkButton
            case .edit: addLinkButton
            }
        }
    }
    
    private var editButton: some View {
        Button {
            viewModel.edit()
        } label: {
            Image(systemName: "pencil")
                .contentShape(Rectangle())
        }
    }
    
    private var viewLinkButton: some View {
        SafariButton(url: viewModel.headerRecipeURL) {
            ZStack {
                Image(systemName: "link.badge.plus").opacity(0)
                Image(systemName: "link")
            }
            .contentShape(Rectangle())
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
                .contentShape(Rectangle())
        }
        .foregroundColor(.accent1)
    }
    
    private var deleteAlert: Alert {
        Alert(
            title: Text("Delete"),
            message: Text("Are you sure you want to delete this recipe?"),
            primaryButton: .destructive(Text("Confirm")) {
                viewModel.delete()
                dismiss()
            },
            secondaryButton: .cancel()
        )
    }
}

struct RecipeView_Header_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.init(), mode: .edit, database: .preview)
        RecipeView(.preview, mode: .plan, database: .preview)
        RecipeView(.preview, mode: .make, database: .preview)
    }
}
