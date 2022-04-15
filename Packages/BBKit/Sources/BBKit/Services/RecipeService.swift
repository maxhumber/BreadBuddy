import Foundation

public class RecipeService {
    public init() {}
    
    public func group(_ steps: [Step]) -> [StepGroup] {
        Dictionary(grouping: steps) { $0.group }
            .map { StepGroup(date: $0.value[0].timeStart, steps: $0.value) }
            .sorted { $0.date < $1.date }
    }
    
    public func rewind(_ recipe: Recipe) -> Recipe {
        var updatedRecipe = recipe
        var time = recipe.timeEnd
        for (index, step) in updatedRecipe.steps.reversed().enumerated() {
            time = next(time, using: step, subtracting: true)
            updatedRecipe.steps[index].timeStart = time
        }
        return updatedRecipe
    }
    
    public func fastforward(_ recipe: Recipe) -> Recipe {
        var updatedRecipe = recipe
        var time = Date()
        for (index, step) in updatedRecipe.steps.enumerated() {
            updatedRecipe.steps[index].timeStart = time
            time = next(time, using: step)
        }
        updatedRecipe.timeEnd = time
        return updatedRecipe
    }
    
    private func next(_ time: Date, using step: Step, subtracting: Bool = false) -> Date {
        let value = step.timeValue * (subtracting ? -1 : 1)
        switch step.timeUnit {
        case .minutes:
            return time.withAdded(minutes: value)
        case .hours:
            return time.withAdded(hours: value)
        case .days:
            return time.withAdded(days: value)
        }
    }
}
