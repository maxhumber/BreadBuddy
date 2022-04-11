import Combine
import Foundation

final class ViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var date: Date
    @Published var step: Step = .init()

    init(recipe: Recipe, date: Date? = nil) {
        self.recipe = recipe
        let nextSunday = Date().next(.sunday)?.withAdded(hours: 15)
        self.date = date ?? nextSunday ?? Date()
    }

    @MainActor func add() {
        if step.timeInMinutes != 0 {
            recipe.steps.append(step)
            step = .init()
            refresh()
        }
    }

    func remove(at offsets: IndexSet) {
        recipe.steps.remove(atOffsets: offsets)
    }

    @MainActor func refresh() {
        var currentTime = date
        for step in recipe.steps.reversed() {
            #warning("need to fix this")
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


#warning("to implement")
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
            //            if step.timeInMinutes != 0 {
            updatedRecipe.steps.append(step)
            self.step = .init()
            //            }
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


