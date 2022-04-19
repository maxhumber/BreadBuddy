import Core
import CustomUI
import SwiftUI

extension RecipeView {
    var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                switch viewModel.mode {
                case .display:
                    displayContent
                case .active:
                    displayContent
                case .edit:
                    editContent
                }
            }
            .padding(.horizontal)
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
