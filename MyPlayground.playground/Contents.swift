import UIKit

let formatter = DateFormatter()
formatter.locale = Locale(identifier: "en_US_POSIX")
formatter.dateFormat = "yyyy-MM-dd HH:mm"
let date = formatter.date(from: "2022-01-31 02:22")

extension Date {
    init(string: String) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd h:mma"
        self = formatter.date(from: string)!
    }
}

Date(string: "2022-01-31 2:22pm")
