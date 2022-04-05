import Foundation

struct Step {
    var id: UUID = .init()
    var description: String
    var timeValue: TimeInterval
    var timeUnit: TimeUnit = .minutes
    var date: Date?
}

extension Step: Identifiable {}

extension Step: Equatable {}
