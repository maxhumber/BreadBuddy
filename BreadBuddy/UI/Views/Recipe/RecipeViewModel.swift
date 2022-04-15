import BBKit
import Combine
import Foundation

@MainActor final class RecipeViewModel: ObservableObject {
    @Published var deleteAlertIsPresented = false
    @Published var newStep: Step = .init()
    @Published var stepGroups = [StepGroup]()
    @Published var recipe: Recipe
    @Published var mode: RecipeMode
    private var database: Database
    private var service = RecipeService()

    init(_ recipe: Recipe, mode: RecipeMode, database: Database = .shared) {
        self.recipe = recipe
        self.mode = recipe.isActive ? .active : mode
        self.database = database
    }
    
    func save() {
        Task(priority: .userInitiated) {
            var updatedRecipe = self.recipe
            try await database.save(&updatedRecipe)
            self.recipe = updatedRecipe
        }
    }
    
    func delete() {
        Task(priority: .userInitiated) {
            try? await database.delete(recipe)
        }
    }
    
    func didAppear() {
        if !recipe.isActive {
            fastforward()
        }
        regroup()
    }
    
    func regroup() {
        stepGroups = service.group(recipe.steps)
    }
    
    func refresh() {
        recipe = service.rewind(recipe)
    }
    
    func fastforward() {
        recipe = service.fastforward(recipe)
    }
}
