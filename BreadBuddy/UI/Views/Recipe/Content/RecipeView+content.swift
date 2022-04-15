import SwiftUI

extension RecipeView {
    @ViewBuilder var content: some View {
        switch viewModel.mode {
        case .active, .display:
            DisplayContent(recipe: viewModel.recipe)
        case .edit:
            EditContent(recipe: $viewModel.recipe)
        }
    }
}

struct RecipeView_Content_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: .preview, mode: .display)
        RecipeView(recipe: .preview, mode: .edit)
        RecipeView(recipe: .preview, mode: .active)
    }
}
