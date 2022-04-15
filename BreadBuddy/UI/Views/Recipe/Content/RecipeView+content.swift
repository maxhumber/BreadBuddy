import SwiftUI

extension RecipeView {
    @ViewBuilder var content: some View {
        switch viewModel.mode {
        case .active, .display:
            DisplayContent(recipe: viewModel.recipe)
        case .edit:
            EditContent()
        }
    }
}

struct RecipeView_Content_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .empty())
        RecipeView(.preview, mode: .edit, database: .empty())
        RecipeView(.preview, mode: .active, database: .empty())
    }
}
