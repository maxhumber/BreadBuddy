import Foundation
import GRDB

struct Todo {
    var id: Int64?
    var label: String
    var completed: Bool
}

extension Todo: Identifiable {}
extension Todo: Equatable {}

extension Todo: Codable, FetchableRecord, MutablePersistableRecord {
    mutating func didInsert(with rowID: Int64, for column: String?) {
        self.id = rowID
    }
}
