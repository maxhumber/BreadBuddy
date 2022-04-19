import CustomUI
import SwiftUI

extension RecipeView {
    @ViewBuilder var displayContent: some View {
        ForEach(viewModel.groups) { group in
            Divider(group.label.uppercased())
                .padding(.horizontal)
            ForEach(group.steps) { step in
                DisplayStep(step)
            }
        }
    }
}

struct RecipeView_displayContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .preview)
    }
}
