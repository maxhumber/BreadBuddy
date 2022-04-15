import Foundation

public enum TimeUnit: Codable, Identifiable, CaseIterable {
    case minutes
    case hours
    case days
}

extension TimeUnit {
    public var id: String {
        label
    }
    
    public var label: String {
        switch self {
        case .minutes: return "Minutes"
        case .hours: return "Hours"
        case .days: return "Days"
        }
    }
    
    public var shortHand: String {
        switch self {
        case .minutes: return "mins"
        case .hours: return "hrs"
        case .days: return "days"
        }
    }
}
