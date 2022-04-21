import CustomUI
import SwiftUI

extension RecipeView {
    @ViewBuilder var displayContent: some View {
        if viewModel.displayEmptyContent {
            emptyContent
        } else {
            scrollablePopulatedContent
        }
    }
    
    private var emptyContent: some View {
        VStack(spacing: 20) {
            Spacer()
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
            Spacer()
        }
    }
    
    private var scrollablePopulatedContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                populatedContent
            }
            .padding(.horizontal, 10)
        }
    }
    
    @ViewBuilder private var populatedContent: some View {
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
            }
        }
        Spacer()
            .frame(height: 50)
    }
}

struct RecipeView_displayContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .preview)
        RecipeView(.init(), mode: .display, database: .preview)
    }
}
