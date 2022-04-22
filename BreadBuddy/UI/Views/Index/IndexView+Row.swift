import Core
import CustomUI
import SwiftUI

extension IndexView {
    struct Row: View {
        private var recipe: Recipe
        private var onDisappear: () -> ()
        
        init(_ recipe: Recipe, onDisappear: @escaping () -> ()) {
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
            HStack(spacing: 4) {
                icon
                Text(subtitle)
            }
            .font(.matter(.caption2, emphasis: .italic))
            .foregroundColor(.text2)
        }
        
        @ViewBuilder private var icon: some View {
            if recipe.isActive {
                Image(systemName: "calendar")
                    .opacity(0.8)
            } else {
                Image(systemName: "hourglass")
                    .opacity(0.8)
            }
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
