import CustomUI
import SwiftUI

extension RecipeView {
    @ViewBuilder var displayContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                innerDisplayContent
            }
            .padding(.horizontal, 10)
        }
    }
    
    @ViewBuilder private var innerDisplayContent: some View {
        ForEach(viewModel.groups) { group in
            Divider {
                Text(group.label.uppercased())
                    .tracking(2)
                    .font(.matter(.caption))
            }
            .padding(.horizontal)
            .foregroundColor(.accent1)
            ForEach(group.steps) { step in
                DisplayStep(step)
                    .onTapGesture(count: 2) {
                        viewModel.doubleTapAction()
                    }
            }
        }
        Spacer()
            .frame(height: 50)
    }
}

struct RecipeView_displayContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .preview)
    }
}
