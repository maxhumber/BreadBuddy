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
    
    public var sortableDate: Date {
        date ?? Date()
    }
    
    public var label: String {
        guard let date = date else { return "Unknown" }
        if Calendar.current.isDateInToday(date) { return "Today" }
        if Calendar.current.isDateInTomorrow(date) { return "Tomorrow" }
        if Calendar.current.isDateInYesterday(date) { return "Yesterday" }
        return date.weekday()
    }
}
