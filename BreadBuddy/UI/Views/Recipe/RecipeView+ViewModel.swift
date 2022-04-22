import Core
import Foundation

extension RecipeView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var newStep = Step()
        @Published var groups = [StepGroup]()
        @Published var recipe: Recipe
        @Published var mode: Mode
        private var store: RecipeStoring
        private var service: RecipeService
        
        init(_ recipe: Recipe, mode: Mode, store: RecipeStoring, service: RecipeService = .init()) {
            self.recipe = recipe
            self.mode = recipe.isActive ? .make : mode
            self.service = service
            self.store = store
        }
        
        func didAppear() {
            if !recipe.isActive { reforward() }
            regroup()
        }
        
        func edit() {
            mode = .edit
        }
        
        func save() {
            Task(priority: .userInitiated) {
                recipe = try await store.save(recipe)
            }
        }
        
        func delete() {
            Task(priority: .userInitiated) {
                try await store.delete(recipe)
            }
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
