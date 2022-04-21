import Core
import CustomUI
import SwiftUI

extension RecipeView {
    @ViewBuilder var content: some View {
        switch viewModel.mode {
        case .plan:
            planContent
        case .make:
            planContent
        case .edit:
            editContent
        }
    }
}

struct RecipeView_Content_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .plan, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.preview, mode: .make, database: .preview)
    }
}
