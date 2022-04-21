import Core
import Combine

final class IndexViewModel: ObservableObject {
    @Published var addViewIsPresented = false
    @Published var error: Error? = nil
    @Published var recipesInProgress = [Recipe]()
    @Published var recipes = [Recipe]()
    
    private var repository: RecipeRepository
    
    init(repository: RecipeRepository = GRDBRecipeRepository()) {
        self.repository = repository
        self.repository.observe(
            onError: { self.error = $0 },
            onChange: { recipes in
                self.recipesInProgress = recipes.filter { $0.isActive }
                self.recipes = recipes.filter { !$0.isActive }
            }
        )
    }
    
    func addButtonAction() {
        addViewIsPresented = true
    }
    
    var inProgressSectionIsDisplayed: Bool {
        !recipesInProgress.isEmpty
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
