import Core
import Combine

extension IndexView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var activeRecipes = [Recipe]()
        @Published var inactiveRecipes = [Recipe]()
        private let store: RecipeStoring
        
        init(store: RecipeStoring) {
            self.store = store
            refresh()
        }
        
        func refresh() {
            Task {
                let recipes = try await store.fetch()
                self.activeRecipes = recipes.filter { $0.isActive }
                self.inactiveRecipes = recipes.filter { !$0.isActive }
            }
        }
        
        var emptyContentIsDisplayed: Bool {
            inactiveRecipes.isEmpty && activeRecipes.isEmpty
        }
        
        var activeSectionIsDisplayed: Bool {
            !activeRecipes.isEmpty
        }
        
        var recipeDividerIsDisplayed: Bool {
            !inactiveRecipes.isEmpty
        }
    }
}
