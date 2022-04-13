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
            
        }
    }
    
    func didChange(timeUnit: TimeUnit) {
        refresh()
    }
    
    func didSubmit(_ field: inout StepField?) {
        switch field {
        case .description:
            field = .timeInMinutes
        case .timeInMinutes:
            field = .none
            refresh()
        default:
            break
        }
    }
    
//    private
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
    
    @MainActor func back(_ action: @escaping () -> ()) {
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
    
    @MainActor private func save() {
        Task {
            var updatedRecipe = self.recipe
            try await database.save(&updatedRecipe)
            self.recipe = updatedRecipe
        }
    }
}
