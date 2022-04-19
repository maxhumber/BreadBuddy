import Foundation

extension Date {
    public var simple: String {
        if isYesterday { return "Yesterday" }
        if isToday { return "Today" }
        if isTomorrow { return "Tomorrow" }
        if self > Date() && self <= Calendar.current.date(byAdding: .day, value: 6, to: self)! {
            return Formatter.weekday.string(from: self)
        }
        return Formatter.iso8601.string(from: self)
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
}
