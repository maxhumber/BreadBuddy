import XCTest
@testable import BreadKit

final class RecipeServiceTests: XCTestCase {
    func testNext() {
        let service = RecipeService()
        let start = Date()
        let duration = 30
        let step = Step(description: "Step X", timeValue: Double(duration), timeUnit: .minutes)
        let end = service.next(start, using: step)
        let delta = Calendar.current.dateComponents([.minute], from: start, to: end).minute
        XCTAssertEqual(delta, duration)
    }
    
    func testRewind() {
        let service = RecipeService()
        let end = Date()
        let steps = [
            Step(description: "Step 1", timeValue: 15, timeUnit: .minutes),
            Step(description: "Step 2", timeValue: 15, timeUnit: .minutes),
            Step(description: "Step 3", timeValue: 15, timeUnit: .minutes),
            Step(description: "Step 4", timeValue: 15, timeUnit: .minutes),
        ]
        var recipe = Recipe(name: "Test", timeEnd: end, steps: steps)
        recipe = service.rewind(recipe)
        let start = recipe.steps.first!.timeStart!
        let delta = Calendar.current.dateComponents([.hour], from: start, to: end).hour
        XCTAssertEqual(delta, 1)
    }
    
    func testReforward() {
        let service = RecipeService()
        let steps = [
            Step(description: "Step 1", timeValue: 1, timeUnit: .hours),
            Step(description: "Step 2", timeValue: 1, timeUnit: .hours),
            Step(description: "Step 3", timeValue: 1, timeUnit: .hours),
        ]
        var recipe = Recipe(name: "Test", steps: steps)
        recipe = service.reforward(recipe)
        let start = recipe.steps.first!.timeStart!
        let now = Date()
        let same = Calendar.current.isDate(now, equalTo: start, toGranularity: .minute)
        XCTAssert(same)
    }
}
