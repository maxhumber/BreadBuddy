import Foundation

public struct StepGroup: Identifiable {
    public var id: UUID
    public var date: Date
    public var steps: [Step]
    
    public init(id: UUID = .init(), date: Date? = nil, steps: [Step]) {
        self.id = id
        self.date = date ?? Date()
        self.steps = steps
    }
}
