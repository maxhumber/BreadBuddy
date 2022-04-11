import Foundation

struct Step {
    var id: UUID
    var description: String
    var timeInMinutes: Int
    var timeUnitPreferrence: TimeUnit
    var timeStart: Date?
}

extension Step {
    init(description: String = "", timeInMinutes: Int = 0, timeUnitPreferrence: TimeUnit = .hours) {
        self.id = .init()
        self.description = description
        self.timeInMinutes = timeInMinutes
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
