import Sugar
import SwiftUI

extension RecipeView {
    var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                switch viewModel.mode {
                case .plan: planContent
                case .edit: editContent
                case .make: planContent
                }
            }
            .padding(.horizontal, 10)
        }
    }
    
    @ViewBuilder private var planContent: some View {
        ForEach(viewModel.groups) { group in
            Divider {
                Text(group.label.uppercased())
                    .tracking(2)
                    .font(.matter(.caption))
            }
            .padding(.horizontal)
            .foregroundColor(.accent1)
            ForEach(group.steps) { step in
                PlanRow(step)
                    .onTapGesture(count: 2) {
                        viewModel.edit()
                    }
            }
        }
        Spacer()
            .frame(height: 50)
    }
    
    @ViewBuilder var editContent: some View {
        ForEach($viewModel.recipe.steps) { $step in
            EditRow($step)
                .padding(.top, 5)
        }
        EditRow($viewModel.newStep, mode: .new)
            .padding(.top, 5)
        Spacer()
            .padding(.bottom, 200)
    }
}

struct RecipeView_Content_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .plan, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.preview, mode: .make, database: .preview)
    }
}
