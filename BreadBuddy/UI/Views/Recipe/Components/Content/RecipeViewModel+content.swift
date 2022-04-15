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
}
