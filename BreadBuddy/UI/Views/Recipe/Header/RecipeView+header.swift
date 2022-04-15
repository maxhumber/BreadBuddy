import SwiftUI

extension RecipeView {
    var header: some View {
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
        .if(viewModel.mode == .edit) {
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
                //                dismiss()
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .opacity(viewModel.mode == .edit ? 1 : 0)
        }
    }
    
    private var backButton: some View {
        Button {
            //            viewModel.back { dismiss() }
        } label: {
            Image(systemName: "chevron.left")
                .contentShape(Rectangle())
        }
        .alert(isPresented: $viewModel.dimissAlertIsDisplayed) {
            dismissAlert
        }
        .opacity(viewModel.mode == .edit ? 0 : 1)
    }
    
    private var dismissAlert: Alert {
        Alert(
            title: Text("Missing Name"),
            message: Text("Recipe must have a name in order to continue"),
            dismissButton: .default(Text("Okay"))
        )
    }
}

struct RecipeView_Header_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: .preview, mode: .display)
        RecipeView(recipe: .preview, mode: .edit)
        RecipeView(recipe: .preview, mode: .active)
    }
}
