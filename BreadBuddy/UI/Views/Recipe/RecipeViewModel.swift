import BreadKit
import Foundation

@MainActor final class RecipeViewModel: ObservableObject {
    @Published var deleteAlertIsPresented = false
    @Published var urlTextAlertIsPresented = false
    @Published var newStep = Step()
    @Published var groups = [StepGroup]()

    @Published var recipe: Recipe
    @Published var mode: RecipeMode
    
    private var repository: RecipeRepository
    private var service: RecipeService

    init(_ recipe: Recipe, mode: RecipeMode, repository: RecipeRepository = GRDBRecipeRepository(), service: RecipeService = .init()) {
        self.recipe = recipe
        self.mode = recipe.isActive ? .active : mode
        self.repository = repository
        self.service = service
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
            reforward()
        }
    }
    
    func refresh() {
        recipe = service.rewind(recipe)
        groups = service.group(recipe)
    }
    
    func reforward() {
        recipe = service.reforward(recipe)
        groups = service.group(recipe)
    }
}
