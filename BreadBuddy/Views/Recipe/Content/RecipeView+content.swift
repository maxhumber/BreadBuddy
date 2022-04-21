import Core
import CustomUI
import SwiftUI

extension RecipeView {
    @ViewBuilder var content: some View {
        switch viewModel.mode {
        case .display:
            displayContent
        case .active:
            displayContent
        case .edit:
            editContent
        }
    }
}

struct RecipeView_Content_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.preview, mode: .active, database: .preview)
    }
}
