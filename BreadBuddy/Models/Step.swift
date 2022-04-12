import Foundation

struct Step {
    var id: UUID = .init()
    var description: String
    var timeValue: Double
    var timeUnitPreferrence: TimeUnit
    var timeStart: Date?
}

extension Step {
    init(description: String = "", timeValue: Double = 0, timeUnitPreferrence: TimeUnit = .hours) {
        self.description = description
        self.timeValue = timeValue
        self.timeUnitPreferrence = timeUnitPreferrence
    }
}

extension Step: Identifiable {}

extension Step: Equatable {}

extension Step: Codable {}

extension Step {
    var timeStartIsPast: Bool {
        guard let date = timeStart else { return false }
        return date < Date()
    }
}

extension Step {
    static let preview = Step(
        description: "Bake",
        timeValue: 30,
        timeUnitPreferrence: .minutes,
        timeStart: Date().withAdded(hours: 3)
    )
}
