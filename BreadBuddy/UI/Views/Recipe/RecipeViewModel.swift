import Combine
import Foundation

final class RecipeViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var newStep: Step = .init()
    @Published var dimissAlertIsDisplayed = false
    
    private let database: Database
    private var cancellables = Set<AnyCancellable>()

    init(recipe: Recipe, database: Database = .shared) {
        self.recipe = recipe
        self.database = database
    }

    func didAppear() {
        refresh()
    }
    
    func didChange(timeEnd: Date) {
        refresh()
    }
    
    func didChange(field: StepField?) {
        if field == .none {
            print("Did dismiss field")
        }
    }
    
    func didChange(timeUnit: TimeUnit) {
        print("Did change time unit preference to: \(timeUnit.rawValue)")
    }
    
    func didSubmit(_ field: inout StepField?) {
        print("Did submit field: \(field!)")
        switch field {
        case .description:
            field = .timeInMinutes
        case .timeInMinutes:
            field = .none
        default:
            break
        }
    }
    
    private func refresh() {
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
    
    func back(_ action: @escaping () -> ()) {
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
}
