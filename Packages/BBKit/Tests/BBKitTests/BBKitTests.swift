import XCTest
@testable import BBKit

final class RecipeServiceTests: XCTestCase {
    func testRewind() {
        let timeEnd = Date()
        let steps = [
            Step(description: "Step 1", timeValue: 15, timeUnit: .minutes),
            Step(description: "Step 2", timeValue: 15, timeUnit: .minutes),
            Step(description: "Step 3", timeValue: 15, timeUnit: .minutes),
            Step(description: "Step 4", timeValue: 15, timeUnit: .minutes),
        ]
        let recipe = Recipe(name: "Test", timeEnd: timeEnd, steps: steps)
        let service = RecipeService()
        let rr = service.rewind(recipe)
        rr.steps.map { print($0.description, $0.timeStart) }
    }
}
