import Combine
import Foundation

@MainActor final class RecipeViewModel: ObservableObject {
    @Published var date: Date
    @Published var recipe: Recipe
    @Published var newStep: Step = .init()
    
    private let database: Database
    private var cancellables = Set<AnyCancellable>()

    init(date: Date? = nil, recipe: Recipe, database: Database = .shared) {
        let nextSunday = Date().next(.sunday)!.withAdded(hours: 15)
        self.date = date ?? nextSunday
        self.recipe = recipe
        self.database = database
    }

    func save() {
        guard !recipe.name.isEmpty else { return }
        Task {
            var updatedRecipe = self.recipe
            try await database.save(&updatedRecipe)
            self.recipe = updatedRecipe
        }
    }
    
    func add() {
        Task {
            var updatedRecipe = self.recipe
            if newStep.timeInMinutes != 0 {
                updatedRecipe.steps.append(newStep)
                newStep = .init()
                self.recipe = updatedRecipe
            }
            refresh()
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

    @MainActor func refresh() {
        var currentTime = date
        for step in recipe.steps.reversed() {
            switch step.timeUnitPreferrence {
            case .minutes:
                currentTime = currentTime.withAdded(minutes: -Double(step.timeInMinutes))
            case .hours:
                currentTime = currentTime.withAdded(hours: -Double(step.timeInMinutes))
            case .days:
                currentTime = currentTime.withAdded(days: -Double(step.timeInMinutes))
            }
            if let index = recipe.steps.firstIndex(where: { $0 == step }) {
                recipe.steps[index].timeStart = currentTime
            }
        }
    }
}
