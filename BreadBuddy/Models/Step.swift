import Foundation

struct Step {
    var id: UUID = .init()
    var description: String
    var timeValue: Double
    var timeUnit: TimeUnit
    var timeStart: Date?
}

extension Step {
    init(description: String = "", timeValue: Double = 0, timeUnit: TimeUnit = .hours) {
        self.description = description
        self.timeValue = timeValue
        self.timeUnit = timeUnit
    }
}

extension Step: Identifiable {}

extension Step: Equatable {}

extension Step: Codable {}

extension Step {
    var timeUnitString: String {
        let str = timeUnit.rawValue.capitalized
        if timeValue == 1 {
            return String(str.dropLast())
        } else {
            return str
        }
    }
    
    var timeStartString: String {
        timeStart?.time() ?? ""
    }
    
    var timeStartWeekdayString: String {
        timeStart?.weekday() ?? ""
    }
    
    var timeStartIsPast: Bool {
        guard let date = timeStart else { return false }
        return date < Date()
    }
}

extension Step {
    static let preview = Step(
        description: "Bake",
        timeValue: 30,
        timeUnit: .minutes,
        timeStart: Date().withAdded(hours: 3)
    )
}
