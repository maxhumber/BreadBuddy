import Combine
import Foundation

enum RecipeMode {
    case display
    case active
    case edit
}

final class RecipeViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var mode: RecipeMode
    @Published var dimissAlertIsDisplayed = false
    @Published var newStep: Step = .init()
    
    private let database: Database
    private var cancellables = Set<AnyCancellable>()

    init(recipe: Recipe, mode: RecipeMode = .display, database: Database = .shared) {
        self.recipe = recipe
        self.mode = mode
        self.database = database
    }

    func didAppear() {
        refresh()
    }
    
    func didChange(timeEnd: Date) {
        refresh()
    }
    
    func didChange(to field: StepField?, with mode: StepMode) {
        if field != .none { return }
        if mode == .new {
            if newStep.description.isEmpty { return }
            if newStep.timeValue == 0 { return }
            recipe.steps.append(newStep)
            newStep = .init()
        }
        refresh()
    }
    
    func didChange(_ timeUnit: TimeUnit, with mode: StepMode) {
        if mode == .existing {
            refresh()
        }
    }
    
    private func refresh() {
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
    
    func delete(_ step: Step) {
        if let index = recipe.steps.firstIndex(where: { $0 == step }) {
            recipe.steps.remove(at: index)
        }
    }
    
    func insertBefore(_ step: Step) {
        if let index = recipe.steps.firstIndex(where: { $0 == step }) {
            recipe.steps.insert(.init(), at: index)
        }
    }
    
    func insertAfter(_ step: Step) {
        if let index = recipe.steps.firstIndex(where: { $0 == step }) {
            print("Index: \(index)")
            let newIndex = recipe.steps.index(after: index)
            print("New Index: \(newIndex)")
            recipe.steps.insert(.init(), at: newIndex)
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
