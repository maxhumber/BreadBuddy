import Foundation

public struct Step: Codable, Equatable, Identifiable {
    public var id: UUID
    public var description: String
    public var timeValue: Double
    public var timeUnit: TimeUnit
    public var timeStart: Date?
    
    public init(id: UUID = .init(), description: String = "", timeValue: Double = 0, timeUnit: TimeUnit = .minutes, timeStart: Date? = nil) {
        self.id = id
        self.description = description
        self.timeValue = timeValue
        self.timeUnit = timeUnit
        self.timeStart = timeStart
    }
}

extension Step {
    public var isValid: Bool {
        timeValue != 0 && !description.isEmpty
    }
    
    public var group: String {
        timeStart?.iso8601 ?? "Unknown"
    }

    public var unitLabel: String {
        timeUnit.shortHand(plural: timeValue == 1)
    }
    
    public var clocktimeStart: String {
        timeStart?.clocktime ?? ""
    }
    
    public var duration: String {
        String(format: "%.0f", timeValue) + " " + unitLabel
    }
}
