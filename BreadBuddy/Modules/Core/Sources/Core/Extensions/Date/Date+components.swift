import Foundation

extension Date {
    public func components(_ set: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]) -> DateComponents {
        Calendar.current.dateComponents(set, from: self)
    }
}
