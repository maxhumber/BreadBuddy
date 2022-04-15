import Foundation

struct RecipeDay: Identifiable {
    var id: UUID = .init()
    var date: Date
    var steps: [Step]
}
