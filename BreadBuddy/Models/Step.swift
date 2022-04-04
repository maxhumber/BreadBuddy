import Foundation

struct Step {
    var label: String
    var timeValue: TimeInterval
    var timeUnit: TimeUnit = .minute
    var date: Date?
}

extension Step: Identifiable {
    var id: UUID {
        UUID()
    }
}

extension Step: Equatable {}
