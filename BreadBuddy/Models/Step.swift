import Foundation

struct Step {
    var id: UUID = .init()
    var description: String = ""
    var timeValue: TimeInterval = 30
    var timeUnit: TimeUnit = .minutes
    var date: Date?
}

extension Step {
    var isInPast: Bool {
        guard let date = date else { return false }
        return date < Date()
    }
}

extension Step: Identifiable {}

extension Step: Equatable {}
