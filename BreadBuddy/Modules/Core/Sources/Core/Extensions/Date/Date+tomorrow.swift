import Foundation

extension Date {
    public static var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: .now)!
    }
}
