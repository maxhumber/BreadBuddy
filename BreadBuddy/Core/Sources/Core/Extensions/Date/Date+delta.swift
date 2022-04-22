import Foundation

extension Date {
    public func delta(to end: Date) -> String {
        let end = end.addingTimeInterval(1)
        let components = Calendar.current.dateComponents([.day, .hour, .minute], from: self, to: end)
        let (days, hours, mins) = (components.day!, components.hour!, components.minute!)
        let (weeks, remainder) = days.quotientAndRemainder(dividingBy: 7)
        let isWeekable = (weeks != 0) && (remainder == 0)
        switch (isWeekable, days, hours, mins) {
        case (true, 1..., _, _):
            return "\(weeks) week" + (weeks == 1 ? "" : "s")
        case (false, 1..., 6..., _):
            return "Over \(days) day" + (days == 1 ? "" : "s")
        case (false, 1..., ..<6, _):
            return "\(days) day" + (days == 1 ? "" : "s")
        case (false, 0, 1..., 6...):
            return "Over \(hours) hour" + (hours == 1 ? "" : "s")
        case (false, 0, 1..., ..<6):
            return "\(hours) hour" + (hours == 1 ? "" : "s")
        case (false, 0, 0, mins):
            return "\(mins) min" + (mins == 1 ? "" : "s")
        default:
            return "Unknown"
        }
    }
}
