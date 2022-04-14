import Foundation

enum TimeUnit: String {
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
    
    var label: String {
        rawValue
    }
    
    var shortHand: String {
        switch self {
        case .minutes:
            return "mins"
        case .hours:
            return "hrs"
        case .days:
            return "days"
        }
    }
}

extension TimeUnit: Codable {}

extension TimeUnit: CaseIterable {}

extension TimeUnit: Identifiable {
    var id: String {
        rawValue
    }
}
