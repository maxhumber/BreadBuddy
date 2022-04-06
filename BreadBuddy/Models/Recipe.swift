import Foundation

struct Recipe {
    var id: UUID = .init()
    var label: String = ""
    var note: String = ""
    var steps: [Step2] = [Step2]()
}

struct Step2 {
    var id: UUID = .init()
    var description: String = ""
    var time: Time
}

struct Time {
    var value: Double = 0
    var unit: TimeUnit = .minutes
}
