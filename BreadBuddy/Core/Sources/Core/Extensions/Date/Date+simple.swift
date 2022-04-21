import Foundation

extension Date {
    public var simple: String {
        if self <= Calendar.current.date(byAdding: .day, value: -2, to: .now)! {
            return Formatter.iso8601.string(from: self)
        } else if isYesterday {
            return "Yesterday"
        } else if isToday {
            return "Today"
        } else if isTomorrow {
            return "Tomorrow"
        } else if self <= Calendar.current.date(byAdding: .day, value: 6, to: .now)! {
            return Formatter.weekday.string(from: self)
        } else {
            return Formatter.iso8601.string(from: self)
        }
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
