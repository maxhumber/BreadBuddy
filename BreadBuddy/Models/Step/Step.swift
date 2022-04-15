import Foundation

struct Step: Codable, Equatable, Identifiable {
    var id: UUID = .init()
    var description: String = ""
    var timeValue: Double = 0
    var timeUnit: TimeUnit = .minutes
    var timeStart: Date?
}

extension Step {
    var group: String {
        timeStart?.iso8601 ?? "Unknown"
    }
    
    var timeUnitString: String {
        let str = timeUnit.shortHand
        return timeValue == 1 ? String(str.dropLast()) : str
    }
    
    var timeStartString: String {
        timeStart?.time().lowercased() ?? ""
    }
    
    var timeStartWeekdayString: String {
        timeStart?.weekday() ?? ""
    }
    
    var durationString: String {
        String(format: "%.0f", timeValue) + " " + timeUnitString
    }
}

extension Step {
    var startTimeString: String {
        let day = timeStart?.weekday()
        let time = timeStart?.time().lowercased()
        guard let day = day, let time = time else { return "" }
        return "\(day) • \(time)"
    }
}
