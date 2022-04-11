import Combine
import Foundation

final class ViewModel: ObservableObject {
    private let database: Database
    private var cancellables = Set<AnyCancellable>()
    @Published var recipe: Recipe
    @Published var date: Date
    @Published var step: Step = .init()

    init(recipe: Recipe, date: Date? = nil, database: Database = .shared) {
        self.recipe = recipe
        let nextSunday = Date().next(.sunday)?.withAdded(hours: 15)
        self.date = date ?? nextSunday ?? Date()
        self.database = database
    }

    @MainActor func add() {
        Task {
            var updatedRecipe = self.recipe
            if step.timeInMinutes != 0 {
                updatedRecipe.steps.append(step)
                step = .init()

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

    func remove(at offsets: IndexSet) {
        recipe.steps.remove(atOffsets: offsets)
    }

    @MainActor func refresh() {
        var currentTime = date
        for step in recipe.steps.reversed() {
            #warning("need to fix this??")
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
