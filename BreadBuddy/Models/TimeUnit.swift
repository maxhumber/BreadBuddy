import Foundation

enum TimeUnit: String, CaseIterable {
    case minute = "Minute"
    case hour = "Hour"
    case day = "Day"

    func label(for value: Double) -> String {
        value == 1 ? rawValue : rawValue + "s"
    }
}

extension TimeUnit: Identifiable {
    var id: String {
        rawValue
    }
}
