import Foundation

extension Date {
    public func withAdded(minutes: Double) -> Date {
        addingTimeInterval(minutes * 60)
    }
    
    public func withAdded(hours: Double) -> Date {
        withAdded(minutes: hours * 60)
    }
    
    public func withAdded(days: Double) -> Date {
        withAdded(hours: days * 24)
    }
}

