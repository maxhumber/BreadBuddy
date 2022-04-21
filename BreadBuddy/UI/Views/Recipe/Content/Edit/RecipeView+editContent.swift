import SwiftUI

extension RecipeView {
    var editContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                innerEditContent
            }
            .padding(.horizontal, 10)
        }
    }
    
    @ViewBuilder var innerEditContent: some View {
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
        RecipeView(.init(), mode: .edit, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
    }
}
