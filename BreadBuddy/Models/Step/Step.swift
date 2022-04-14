import Foundation

struct Step: Codable, Equatable, Identifiable {
    var id: UUID = .init()
    var description: String = ""
    var timeValue: Double = 0
    var timeUnit: TimeUnit = .minutes
    var timeStart: Date?
}

extension Step {
    var timeUnitString: String {
        let str = timeUnit.shortHand
        if timeValue == 1 {
            return String(str.dropLast())
        } else {
            return str
        }
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
