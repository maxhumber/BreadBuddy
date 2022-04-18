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
    
    public var isValid: Bool {
        timeValue != 0 && !description.isEmpty
    }
    
    public var group: String {
        timeStart?.iso8601 ?? "Unknown"
    }

    public var timeUnitString: String {
        let str = timeUnit.shortHand
        return timeValue == 1 ? String(str.dropLast()) : str
    }
    
    public var timeStartString: String {
        timeStart?.time().lowercased() ?? ""
    }
    
    public var timeStartWeekdayString: String {
        timeStart?.weekday() ?? ""
    }
    
    public var durationString: String {
        String(format: "%.0f", timeValue) + " " + timeUnitString
    }
    
    public var startTimeString: String {
        let day = timeStart?.weekday()
        let time = timeStart?.time().lowercased()
        guard let day = day, let time = time else { return "" }
        return "\(day) • \(time)"
    }
}
