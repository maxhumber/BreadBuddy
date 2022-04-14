import Foundation

enum TimeUnit: Codable, Identifiable, CaseIterable {
    case minutes
    case hours
    case days
}

extension TimeUnit {
    var id: String {
        label
    }
    
    var label: String {
        switch self {
        case .minutes: return "Minutes"
        case .hours: return "Hours"
        case .days: return "Days"
        }
    }
    
    var shortHand: String {
        switch self {
        case .minutes: return "mins"
        case .hours: return "hrs"
        case .days: return "days"
        }
    }
}
