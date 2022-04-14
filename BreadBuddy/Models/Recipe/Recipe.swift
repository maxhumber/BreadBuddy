import Foundation

struct Recipe: Codable, Equatable, Identifiable {
    var id: Int64?
    var name: String = ""
    var timeEnd: Date = .next(.sunday).withAdded(hours: 15)
    var steps: [Step] = [Step]()
    var isActive: Bool = false
}
