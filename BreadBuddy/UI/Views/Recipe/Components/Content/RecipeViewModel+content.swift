import BreadKit
import Foundation

extension RecipeViewModel {
    var lastStep: Step {
        Step(description: "Ready", timeValue: 0, timeStart: recipe.timeEnd)
    }
    
//    var shouldDisplayLastStepDivider: Bool {
//        lastStep.group != groups.last?.steps.last?.group
//    }
//
//    var lastStepDividerLabel: String {
//        lastStep.timeStart?.dayOfWeek() ?? "Unknown"
//    }
    
    func didChange(to field: StepEditField?, with mode: StepEditMode) {
        if field == .none && mode == .new && newStep.isValid {
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
        if var index = recipe.steps.firstIndex(of: step) {
            if after {
                index = recipe.steps.index(after: index)
            }
            recipe.steps.insert(.init(), at: index)
        }
    }
}
