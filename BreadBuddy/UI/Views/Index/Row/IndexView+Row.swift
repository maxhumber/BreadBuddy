import Core
import CustomUI
import SwiftUI

extension IndexView {
    struct Row: View {
        var recipe: Recipe
        var onDisappear: () -> ()
        
        init(recipe: Recipe, onDisappear: @escaping () -> ()) {
            self.recipe = recipe
            self.onDisappear = onDisappear
        }
        
        var body: some View {
            StealthNavigationLink {
                RecipeView(recipe, mode: .plan)
                    .onDisappear { onDisappear() }
            } label: {
                content
            }
        }
        
        private var content: some View {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    topRow
                    bottomRow
                }
                Spacer()
            }
        }
        
        private var topRow: some View {
            Text(recipe.name)
                .font(.matter())
                .foregroundColor(.text1)
        }
        
        private var bottomRow: some View {
            Text(subtitle)
                .font(.matter(.caption2, emphasis: .italic))
                .foregroundColor(.text2)
        }
            
        private var subtitle: String {
            let end = recipe.timeEnd
            if recipe.isActive {
                return end.simple + " at " + end.clocktime
            }
            if let start = recipe.steps.first?.timeStart {
                return start.delta(to: end)
            }
            return "Unknown"
        }
    }
}

struct IndexView_Row_Previews: PreviewProvider {
    static var previews: some View {
        IndexView(.persistent)
        IndexView(.preview)
    }
}