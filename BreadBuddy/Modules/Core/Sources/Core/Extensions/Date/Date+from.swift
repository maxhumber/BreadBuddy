import Foundation

extension Date {
    public init(from string: String) {
        self = Formatter.iso8601(timestamp: true).date(from: string)!
    }
}
