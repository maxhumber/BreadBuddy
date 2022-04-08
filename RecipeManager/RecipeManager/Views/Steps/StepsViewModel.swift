import Foundation
import Combine

@MainActor final class StepsViewModel: ObservableObject {
    private let database: Database
    private var cancellables = Set<AnyCancellable>()
    @Published var recipe: Recipe
    @Published var step: Step
    
    init(recipe: Recipe, database: Database = .shared) {
        self.recipe = recipe
        self.database = database
        self.step = .init()
    }
    
    func save() {
        Task {
            var updatedRecipe = self.recipe
            if step.timeInMinutes != 0 {
                updatedRecipe.steps.append(step)
                step = .init()
            }
            self.recipe = updatedRecipe
            try await database.save(&updatedRecipe)
        }
    }
    
    func update() {
        Task {
            var updatedRecipe = self.recipe
            updatedRecipe.dateModified = Date()
            self.recipe = updatedRecipe
            try await database.save(&updatedRecipe)
        }
    }
}


