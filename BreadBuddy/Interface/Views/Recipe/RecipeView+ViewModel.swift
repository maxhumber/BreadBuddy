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
            if !recipe.isActive { reforward() }
            self.regroup()
        }
        
        // MARK: - shared
        func reforward() {
            recipe = service.reforward(recipe)
            regroup()
        }
        
        private func regroup() {
            groups = service.group(recipe)
        }

        private func save() {
            Task(priority: .userInitiated) {
                recipe = try await store.save(recipe)
            }
        }
        
        func edit() {
            mode = .edit
        }
        
        // MARK: - header
        var cancelButtonIsDisplayed: Bool {
            recipe.id == nil
        }
        
        func delete() {
            Task(priority: .userInitiated) {
                try await store.delete(recipe)
            }
        }
        
        var viewLinkButtonIsDisabled: Bool {
            guard let link = recipe.link else { return true }
            return !link.canOpenUrl()
        }
        
        // MARK: - content
        func addStep() {
            if newStep.isValid {
                recipe.steps.append(newStep)
                newStep = .init()
            }
        }
        
        func delete(_ step: Step) {
            if let index = recipe.steps.firstIndex(of: step) {
                recipe.steps.remove(at: index)
            }
        }
        
        func insert(_ step: Step, after: Bool = false) {
            if var index = recipe.steps.firstIndex(of: step) {
                if after {
                    index = recipe.steps.index(after: index)
                }
                recipe.steps.insert(.init(), at: index)
            }
        }
        
        // MARK: - footer
        var discardButtonIsDislayed: Bool {
            recipe.id != nil
        }
        
        func discard() {
            mode = .plan
        }
        
        var doneButtonIsDisabled: Bool {
            recipe.name.isEmpty || recipe.steps.isEmpty
        }
        
        func done() {
            recipe.steps = recipe.steps.filter { $0.timeValue != 0 }
            mode = .plan
            save()
            reforward()
        }
        
        func start() {
            recipe.isActive = true
            mode = .make
            save()
        }
        
        func didChange(_ timeEnd: Date) {
            recipe = service.rewind(recipe)
            regroup()
        }
    
        func reset() {
            reforward()
        }
        
        func stop() {
            recipe.isActive = false
            mode = .plan
            save()
        }
    }
}
