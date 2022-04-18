import Foundation

public struct Recipe: Codable, Equatable, Identifiable {
    public var id: Int64?
    public var name: String
    public var timeEnd: Date
    public var steps: [Step]
    public var isActive: Bool
    
    public init(id: Int64? = nil, name: String = "", timeEnd: Date = Date().withAdded(hours: 6), steps: [Step] = [Step](), isActive: Bool = false) {
        self.id = id
        self.name = name
        self.timeEnd = timeEnd
        self.steps = steps
        self.isActive = isActive
    }
}

extension Recipe {
    public var totalTime: String {
        let end = timeEnd
        guard let start = steps.first?.timeStart else { return "Unknown" }
        guard let delta = Calendar.current.dateComponents([.hour], from: start, to: end).hour else { return "Unknown" }
        return "~\(delta) hours"
    }
}
