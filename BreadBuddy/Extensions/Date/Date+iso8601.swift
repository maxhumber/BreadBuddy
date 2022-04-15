import Foundation

extension Date {
    public var iso8601: String {
        return DateFormatter.iso8601.string(from: self)
    }
    
    init(_ iso8601: String) {
        self = DateFormatter.iso8601.date(from: iso8601)!
    }
}
