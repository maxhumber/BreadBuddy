import Foundation

extension Date {
    public func dayOfWeek(casual: Bool = true) -> String {
        if casual {
            if Calendar.current.isDateInToday(self) { return "Today" }
            if Calendar.current.isDateInTomorrow(self) { return "Tomorrow" }
            if Calendar.current.isDateInYesterday(self) { return "Yesterday" }
        }
        return Formatter.weekday.string(from: self)
    }
}
