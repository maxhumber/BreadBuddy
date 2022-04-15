import Foundation

struct Day: Identifiable {
    var id: UUID = .init()
    var date: Date
    var steps: [Step]
}
