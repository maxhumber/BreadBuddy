import Core
import Combine

extension IndexView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var recipesInProgress = [Recipe]()
        @Published var recipes = [Recipe]()
        private let store: RecipeStoring
        
        init(store: RecipeStoring) {
            self.store = store
        }
        
        func refresh() {
            Task {
                let recipes = try await store.fetch()
                self.recipesInProgress = recipes.filter { $0.isActive }
                self.recipes = recipes.filter { !$0.isActive }
            }
        }
        
        var emptyContentIsDisplayed: Bool {
            recipes.isEmpty && recipesInProgress.isEmpty
        }
        
        var inProgressSectionIsDisplayed: Bool {
            !recipesInProgress.isEmpty
        }
        
        var recipeDividerIsDisplayed: Bool {
            !recipes.isEmpty
        }
        
        func subtitle(for recipe: Recipe) -> String {
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
