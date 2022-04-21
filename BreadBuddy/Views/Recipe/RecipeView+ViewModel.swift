import Core
import Foundation

extension RecipeView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var urlTextAlertIsPresented = false
        @Published var newStep = Step()
        @Published var groups = [StepGroup]()
        @Published var recipe: Recipe
        @Published var mode: Mode
        private var service: RecipeService
        private var repository: RecipeRepository
        
        init(_ recipe: Recipe, mode: Mode, service: RecipeService = .init(), repository: RecipeRepository = GRDBRecipeRepository()) {
            self.recipe = recipe
            self.mode = recipe.isActive ? .make : mode
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
            regroup()
        }
        
        func refresh() {
            recipe = service.rewind(recipe)
            regroup()
        }
        
        func reforward() {
            recipe = service.reforward(recipe)
            regroup()
        }
        
        private func regroup() {
            groups = service.group(recipe)
        }
    }
}
