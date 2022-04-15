import Combine
import Foundation

@MainActor final class RecipeViewModel: ObservableObject {
    @Published var deleteAlertIsPresented = false
    @Published var newStep: Step = .init()
    @Published var recipe: Recipe
    @Published var mode: RecipeMode
    private var database: Database

    init(_ recipe: Recipe, mode: RecipeMode, database: Database = .shared) {
        self.recipe = recipe
        self.mode = mode
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
        
    }
    
    func refresh() {
        var time = recipe.timeEnd
        for step in recipe.steps.reversed() {
            switch step.timeUnit {
            case .minutes:
                time = time.withAdded(minutes: -step.timeValue)
            case .hours:
                time = time.withAdded(hours: -step.timeValue)
            case .days:
                time = time.withAdded(days: -step.timeValue)
            }
            if let index = recipe.steps.firstIndex(where: { $0 == step }) {
                recipe.steps[index].timeStart = time
            }
        }
    }
}
