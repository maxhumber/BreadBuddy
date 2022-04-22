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
        
        private func save() {
            Task(priority: .userInitiated) {
                recipe = try await store.save(recipe)
            }
        }
        
        func delete() {
            Task(priority: .userInitiated) {
                try await store.delete(recipe)
            }
        }
        
        func didAppear() {
            if !recipe.isActive { reforward() }
            regroup()
        }
        
        func didChange(_ timeEnd: Date) {
            recipe = service.rewind(recipe)
            regroup()
        }
        
        func edit() {
            mode = .edit
        }
        
        func discard() {
            mode = .plan
        }
        
        func done() {
            recipe.steps = recipe.steps.filter { $0.timeValue != 0 }
            mode = .plan
            save()
            reforward()
        }
        
        func reforward() {
            recipe = service.reforward(recipe)
            regroup()
        }
        
        func start() {
            recipe.isActive = true
            mode = .make
            save()
        }
        
        func stop() {
            recipe.isActive = false
            mode = .plan
            save()
        }
        
        func reset() {
            reforward()
        }

        private func regroup() {
            groups = service.group(recipe)
        }
    }
}
