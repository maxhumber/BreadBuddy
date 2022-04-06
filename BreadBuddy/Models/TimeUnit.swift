import Foundation

enum TimeUnit: String, CaseIterable {
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"

    func label(for value: Double) -> String {
        value == 1 ? String(rawValue.dropLast()) : rawValue
    }
}

extension TimeUnit: Identifiable {
    var id: String {
        rawValue
    }
}
