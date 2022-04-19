import Core
import Foundation

extension Recipe {
    static let preview = Recipe(
        name: "Maggie's Baguette",
        link: "https://www.kingarthurbaking.com/recipes/sourdough-baguettes-recipe",
        timeEnd: Date(from: "2022-04-17 3:00pm"),
        steps: [
            Step(description: "Mix ingredients", timeValue: 5, timeUnit: .minutes, timeStart: Date(from: "2022-04-17 9:35am")),
            Step(description: "Knead the dough", timeValue: 10, timeUnit: .minutes, timeStart: Date(from: "2022-04-17 9:40am")),
            Step(description: "Bulk rise", timeValue: 90, timeUnit: .minutes, timeStart: Date(from: "2022-04-17 9:50am")),
            Step(description: "Divide and shape", timeValue: 15, timeUnit: .minutes, timeStart: Date(from: "2022-04-17 11:20am")),
            Step(description: "Second rise", timeValue: 2, timeUnit: .hours, timeStart: Date(from: "2022-04-17 11:35am")),
            Step(description: "Bake", timeValue: 25, timeUnit: .minutes, timeStart: Date(from: "2022-04-17 1:35pm")),
            Step(description: "Cool", timeValue: 1, timeUnit: .hours, timeStart: Date(from: "2022-04-17 2:00pm"))
        ]
    )
}
