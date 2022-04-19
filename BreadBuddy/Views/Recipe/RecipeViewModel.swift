import Core
import Foundation

@MainActor final class RecipeViewModel: ObservableObject {
    @Published var deleteAlertIsPresented = false
    @Published var urlTextAlertIsPresented = false
    @Published var newStep = Step()
    @Published var groups = [StepGroup]()

    @Published var recipe: Recipe
    @Published var mode: Mode
    
    private var service: RecipeService
    private var repository: RecipeRepository

    init(_ recipe: Recipe, mode: Mode, service: RecipeService = .init(), repository: RecipeRepository = GRDBRecipeRepository()) {
        self.recipe = recipe
        self.mode = recipe.isActive ? .active : mode
        self.service = service
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
