import Foundation
import GRDB

struct Recipe {
    var id: Int64?
    var name: String
    var date: Date
    var steps: [Step]
    var dateCreated: Date
    var dateModified: Date
}

extension Recipe {
    init(
        name: String = "",
        date: Date = .next(.sunday).withAdded(hours: 15),
        steps: [Step] = [Step]()
    ) {
        self.name = name
        self.date = date
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
        date: .next(.sunday).withAdded(hours: 15),
        steps: [
            Step(description: "Mix ingredients", timeInMinutes: 5, timeUnitPreferrence: .minutes),
            Step(description: "Knead the dough", timeInMinutes: 10, timeUnitPreferrence: .minutes),
            Step(description: "Bulk rise", timeInMinutes: 90, timeUnitPreferrence: .minutes),
            Step(description: "Divide and shape", timeInMinutes: 15, timeUnitPreferrence: .minutes),
            Step(description: "Second rise", timeInMinutes: 2, timeUnitPreferrence: .hours),
            Step(description: "Bake", timeInMinutes: 25, timeUnitPreferrence: .minutes),
            Step(description: "Cool", timeInMinutes: 1, timeUnitPreferrence: .hours)
        ]
    )
}
