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
