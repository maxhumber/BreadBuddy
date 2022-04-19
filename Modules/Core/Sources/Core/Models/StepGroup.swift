import Foundation

public struct StepGroup: Identifiable {
    public var id: UUID
    public var steps: [Step]
    public var date: Date?
    
    public init(_ steps: [Step]) {
        self.id = .init()
        self.steps = steps
        self.date = steps.first?.timeStart
    }
}
    
extension StepGroup {
    public var sortableDate: Date {
        date ?? Date()
    }
    
    public var label: String {
        date?.simple ?? "Unknown"
    }
}
