import Foundation

extension RecipeViewModel {
    var lastStep: Step {
        Step(description: "Ready", timeValue: 0, timeStart: recipe.timeEnd)
    }
    
    var days: [RecipeDay] {
        Dictionary(grouping: recipe.steps) { $0.group }
            .map { RecipeDay(date: $0.value[0].timeStart!, steps: $0.value) }
            .sorted { $0.date < $1.date }
    }
    
    func didChange(to field: StepEditField?, with mode: StepEditMode) {
        if field != .none { return }
        if mode == .new {
            if newStep.description.isEmpty { return }
            if newStep.timeValue == 0 { return }
            recipe.steps.append(newStep)
            newStep = .init()
        }
        refresh()
    }
    
    func didChange(_ timeUnit: TimeUnit, with mode: StepEditMode) {
        if mode == .existing {
            refresh()
        }
    }
    
    func delete(_ step: Step) {
        if let index = recipe.steps.firstIndex(where: { $0 == step }) {
            recipe.steps.remove(at: index)
        }
    }
    
    func insert(_ step: Step, after: Bool = false) {
        if var index = recipe.steps.firstIndex(where: { $0 == step }) {
            if after {
                index = recipe.steps.index(after: index)
            }
            recipe.steps.insert(.init(), at: index)
        }
    }
}
