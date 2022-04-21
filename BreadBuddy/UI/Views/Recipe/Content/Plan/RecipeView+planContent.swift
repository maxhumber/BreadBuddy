import CustomUI
import SwiftUI

extension RecipeView {
    @ViewBuilder var planContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                innerPlanContent
            }
            .padding(.horizontal, 10)
        }
    }
    
    @ViewBuilder private var innerPlanContent: some View {
        ForEach(viewModel.groups) { group in
            Divider {
                Text(group.label.uppercased())
                    .tracking(2)
                    .font(.matter(.caption))
            }
            .padding(.horizontal)
            .foregroundColor(.accent1)
            ForEach(group.steps) { step in
                PlanStep(step)
                    .onTapGesture(count: 2) {
                        viewModel.doubleTapAction()
                    }
            }
        }
        Spacer()
            .frame(height: 50)
    }
}

struct RecipeView_planContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .plan, database: .preview)
    }
}
