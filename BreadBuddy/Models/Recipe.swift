import Foundation
import GRDB

struct Recipe {
    var id: Int64?
    var name: String
    var timeEnd: Date
    var steps: [Step]
    var dateCreated: Date
    var dateModified: Date
}

extension Recipe {
    init(
        name: String = "",
        timeEnd: Date = .next(.sunday).withAdded(hours: 15),
        steps: [Step] = [Step]()
    ) {
        self.name = name
        self.timeEnd = timeEnd
        self.steps = steps
        self.dateCreated = Date()
        self.dateModified = Date()
    }
}

extension Recipe: Identifiable {}

extension Recipe: Equatable {}

extension Recipe: Codable {}

extension Recipe: FetchableRecord {}

extension Recipe: MutablePersistableRecord {
    mutating func didInsert(with rowID: Int64, for column: String?) {
        self.id = rowID
    }
}

extension Recipe {
    static let preview = Recipe(
        name: "Maggie's Baguette",
        timeEnd: .next(.sunday).withAdded(hours: 15),
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
