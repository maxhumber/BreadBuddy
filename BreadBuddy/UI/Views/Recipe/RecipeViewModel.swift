import Combine
import Foundation

@MainActor final class RecipeViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var newStep: Step = .init()
    @Published var dimissAlertIsDisplayed = false
    
    private let database: Database
    private var cancellables = Set<AnyCancellable>()

    init(recipe: Recipe, database: Database = .shared) {
        self.recipe = recipe
        self.database = database
    }

    func backAction(_ action: @escaping () -> ()) {
        switch (recipe.name.isEmpty, recipe.steps.isEmpty) {
        case (true, true):
            action()
        case (true, false):
            dimissAlertIsDisplayed = true
        default:
            save()
            action()
        }
    }
    
    private func save() {
        Task {
            var updatedRecipe = self.recipe
            try await database.save(&updatedRecipe)
            self.recipe = updatedRecipe
        }
    }
    
    func add() {
        Task {
            var updatedRecipe = self.recipe
            if newStep.timeValue != 0 {
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

    func refresh() {
        var time = recipe.timeEnd
        for step in recipe.steps.reversed() {
            switch step.timeUnitPreferrence {
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
