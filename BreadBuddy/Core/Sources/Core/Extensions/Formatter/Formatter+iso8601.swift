import Foundation

extension Formatter {
    public static let iso8601: DateFormatter = iso8601()
    
    public static func iso8601(timestamp: Bool = false) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = timestamp ? "yyyy-MM-dd h:mma" : "yyyy-MM-dd"
        return formatter
    }
}
