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
