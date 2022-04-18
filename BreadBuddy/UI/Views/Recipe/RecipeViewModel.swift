import BBKit
import Foundation

@MainActor final class RecipeViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var mode: RecipeMode
    private var repository: RecipeRepository
    
    @Published var groups = [StepGroup]()
    @Published var newStep: Step = .init()
    @Published var deleteAlertIsPresented = false
    private var service: RecipeService = .init()

    init(_ recipe: Recipe, mode: RecipeMode, repository: RecipeRepository = GRDBRecipeRepository()) {
        self.recipe = recipe
        self.mode = recipe.isActive ? .active : mode
        self.repository = repository
    }
    
    func save() {
        Task(priority: .userInitiated) {
            recipe = try await repository.save(recipe)
        }
    }
    
    func delete() {
        Task(priority: .userInitiated) {
            try await repository.delete(recipe)
        }
    }
    
    func didAppear() {
        if !recipe.isActive {
            fastforward()
        }
        regroup()
    }
    
    func regroup() {
        groups = service.group(recipe.steps)
    }
    
    func refresh() {
        recipe = service.rewind(recipe)
    }
    
    func fastforward() {
        recipe = service.reforward(recipe)
    }
}
