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
    
    public var isPast: Bool {
        guard let timeStart = timeStart else { return false }
        return timeStart < .now
    }
    
    public var group: String {
        timeStart?.iso8601 ?? "Unknown"
    }

    public var unitLabel: String {
        let str = timeUnit.shortHand
        return timeValue == 1 ? String(str.dropLast()) : str
    }
    
    public var clocktimeStart: String {
        timeStart?.clocktime ?? ""
    }
    
    public var duration: String {
        String(format: "%.0f", timeValue) + " " + unitLabel
    }
    
    public var startLabel: String {
        if let day = timeStart?.dayOfWeek(), let time = timeStart?.clocktime {
            return "\(day) • \(time)"
        }
        return ""
    }
}
