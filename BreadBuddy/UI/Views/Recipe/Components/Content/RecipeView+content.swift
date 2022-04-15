import BBKit
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
    
    @ViewBuilder var displayContent: some View {
        ForEach(viewModel.days) { day in
            Divider(day)
            ForEach(day.steps) { step in
                Display(step)
            }
        }
        Display(viewModel.lastStep)
    }
    
    @ViewBuilder var editContent: some View {
        ForEach($viewModel.recipe.steps) { $step in
            Edit($step)
        }
        Edit($viewModel.newStep, mode: .new)
        Edit($viewModel.newStep, mode: .new).opacity(0)
    }
}

struct RecipeView_Content_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .empty)
        RecipeView(.preview, mode: .edit, database: .empty)
        RecipeView(.preview, mode: .active, database: .empty)
    }
}