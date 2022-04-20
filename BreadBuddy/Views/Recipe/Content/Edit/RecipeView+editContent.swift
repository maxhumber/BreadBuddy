import SwiftUI

extension RecipeView {
    @ViewBuilder var editContent: some View {
        ForEach($viewModel.recipe.steps) { $step in
            EditStep($step)
                .padding(.top, 5)
        }
        EditStep($viewModel.newStep, mode: .new)
            .padding(.top, 5)
        Spacer()
            .padding(.bottom, 200)
    }
}

struct RecipeView_editContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .edit, database: .preview)
    }
}
