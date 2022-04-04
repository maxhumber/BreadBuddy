import Foundation

extension Date {
    func withAdded(minutes: Double) -> Date {
        addingTimeInterval(minutes * 60)
    }
    
    func withAdded(hours: Double) -> Date {
        withAdded(minutes: hours * 60)
    }
    
    func withAdded(days: Double) -> Date {
        withAdded(hours: days * 24)
    }
}

extension Date {
    func weekday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    func time() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }
}

extension Date {
    func next(_ weekday: Weekday) -> Date? {
        let calendar = Calendar.current
        let component = DateComponents(calendar: Calendar.current, weekday: weekday.rawValue)
        return calendar.nextDate(after: self, matching: component, matchingPolicy: .nextTimePreservingSmallerComponents)
    }
    
    enum Weekday: Int {
        case sunday = 1
        case monday = 2
        case tuesday = 3
        case wednesday = 4
        case thursday = 5
        case friday = 6
        case saturday = 7
    }
}
