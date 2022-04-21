import Foundation

extension Date {
    public static func next(_ weekday: Weekday) -> Date {
        Date().next(weekday)
    }
    
    public func next(_ weekday: Weekday) -> Date {
        let calendar = Calendar.current
        let component = DateComponents(calendar: calendar, weekday: weekday.rawValue)
        return calendar.nextDate(after: self, matching: component, matchingPolicy: .nextTimePreservingSmallerComponents)!
    }
    
    public enum Weekday: Int {
        case sunday = 1
        case monday = 2
        case tuesday = 3
        case wednesday = 4
        case thursday = 5
        case friday = 6
        case saturday = 7
    }
}
