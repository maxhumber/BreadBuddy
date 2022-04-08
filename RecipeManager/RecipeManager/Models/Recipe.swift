import Foundation
import GRDB

struct Recipe {
    var id: Int64?
    var name: String
    var note: String
    var steps: [Step]
    var dateCreated: Date
    var dateModified: Date
}

extension Recipe {
    init(name: String = "", note: String = "", steps: [Step] = [Step](), dateCreated: Date = Date()) {
        self.name = name
        self.note = note
        self.steps = steps
        self.dateCreated = dateCreated
        self.dateModified = dateCreated
    }
}

extension Recipe: Identifiable {}

extension Recipe: Equatable {}

extension Recipe: Codable {}

extension Recipe: FetchableRecord {}

extension Recipe: MutablePersistableRecord {
    mutating func didInsert(with rowID: Int64, for column: String?) {
        self.id = rowID
    }
}
