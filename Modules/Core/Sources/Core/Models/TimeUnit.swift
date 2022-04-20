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
    
    public func shortHand(plural: Bool = true) -> String {
        switch (self, plural) {
        case (.minutes, true): return "mins"
        case (.minutes, false): return "min"
        case (.hours, true): return "hrs"
        case (.hours, false): return "hr"
        case (.days, true): return "days"
        case (.days, false): return "day"
        }
    }
}
