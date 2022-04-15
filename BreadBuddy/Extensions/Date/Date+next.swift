import Foundation

extension Date {
    static func next(_ weekday: Weekday) -> Date {
        Date().next(weekday)
    }
    
    func next(_ weekday: Weekday) -> Date {
        let calendar = Calendar.current
        let component = DateComponents(calendar: Calendar.current, weekday: weekday.rawValue)
        return calendar.nextDate(after: self, matching: component, matchingPolicy: .nextTimePreservingSmallerComponents)!
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
