import Foundation

extension Date {
    init(string: String) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd h:mma"
        self = formatter.date(from: string)!
    }
}
