import Core
import Foundation

extension Recipe {
    static let preview = Recipe(
        name: "Maggie's Baguette",
        link: "https://www.kingarthurbaking.com/recipes/sourdough-baguettes-recipe",
        timeEnd: .tomorrow,
        steps: [
            Step(description: "Mix ingredients", timeValue: 5, timeUnit: .minutes),
            Step(description: "Knead the dough", timeValue: 10, timeUnit: .minutes),
            Step(description: "Bulk rise", timeValue: 90, timeUnit: .minutes),
            Step(description: "Divide and shape", timeValue: 15, timeUnit: .minutes),
            Step(description: "Second rise", timeValue: 2, timeUnit: .hours),
            Step(description: "Bake", timeValue: 25, timeUnit: .minutes),
            Step(description: "Cool", timeValue: 1, timeUnit: .hours)
        ]
    )
}
