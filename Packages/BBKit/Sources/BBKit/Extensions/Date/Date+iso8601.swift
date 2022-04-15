import Foundation

extension Date {
    public var iso8601: String {
        DateFormatter.iso8601.string(from: self)
    }
    
    public init(_ iso8601: String) {
        self = DateFormatter.iso8601.date(from: iso8601)!
    }
}
