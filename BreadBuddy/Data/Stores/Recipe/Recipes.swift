import Foundation
import Core

extension Recipe {
    static let sourdoughBaguettes = Recipe(
        name: "Sourdough Baguettes",
        link: "https://www.kingarthurbaking.com/recipes/sourdough-baguettes-recipe",
        timeEnd: Date(from: "2022-04-22 6:00pm"),
        steps: [
            Step(description: "Mix ingredients", timeValue: 5, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 12:40pm")),
            Step(description: "Knead dough", timeValue: 10, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 12:45pm")),
            Step(description: "Bulk rise", timeValue: 90, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 12:55pm")),
            Step(description: "Divide and shape", timeValue: 10, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 2:25pm")),
            Step(description: "Second rise", timeValue: 2, timeUnit: .hours, timeStart: Date(from: "2022-04-22 2:35pm")),
            Step(description: "Bake", timeValue: 25, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 4:35pm")),
            Step(description: "Cool", timeValue: 1, timeUnit: .hours, timeStart: Date(from: "2022-04-22 5:00pm"))
        ]
    )
    
    static let overnightPizzaDough = Recipe(
        name: "Easy Overnight Pizza Dough",
        link: "https://www.thecuriouschickpea.com/easy-overnight-pizza-dough",
        timeEnd: Date(from: "2022-04-23 12:30pm"),
        steps: [
            Step(description: "Hydrate yeast", timeValue: 5, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 8:55pm")),
            Step(description: "Mix ingredients", timeValue: 8, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 9:00pm")),
            Step(description: "Cover and rest", timeValue: 20, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 9:08pm")),
            Step(description: "Knead dough", timeValue: 2, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 9:28pm")),
            Step(description: "Bulk rise", timeValue: 1.5, timeUnit: .hours, timeStart: Date(from: "2022-04-22 9:30pm")),
            Step(description: "Shape", timeValue: 10, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 11:00pm")),
            Step(description: "Refridgerate", timeValue: 12, timeUnit: .hours, timeStart: Date(from: "2022-04-22 11:10pm")),
            Step(description: "Relax", timeValue: 1, timeUnit: .hours, timeStart: Date(from: "2022-04-23 11:10am")),
            Step(description: "Bake", timeValue: 20, timeUnit: .minutes, timeStart: Date(from: "2022-04-23 12:10pm"))
        ]
    )
    
    static let sourdoughHamburgerBuns = Recipe(
        name: "Sourdough Hamburger Buns",
        link: "https://lovelylittlekitchen.com/sourdough-hamburger-buns/",
        timeEnd: Date(from: "2022-04-22 6:00pm"),
        steps: [
            Step(description: "Mix ingredients", timeValue: 5, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 1:50pm")),
            Step(description: "Cover and rest", timeValue: 30, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 1:55pm")),
            Step(description: "Knead dough", timeValue: 8, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 2:25pm")),
            Step(description: "Bulk rise", timeValue: (2*60+2), timeUnit: .minutes, timeStart: Date(from: "2022-04-22 2:33pm")),
            Step(description: "Divide and shape", timeValue: 20, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 4:35pm")),
            Step(description: "Second rise", timeValue: 75, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 4:55pm")),
            Step(description: "Bake", timeValue: 20, timeUnit: .minutes, timeStart: Date(from: "2022-04-22 6:10pm"))
        ]
    )
}
