import Foundation
import GRDB

struct Todo {
    var id: Int64?
    var label: String
    var priority: Priority?
}

extension Todo {
    enum Priority: String, Codable, CaseIterable {
        case low
        case medium
        case high
    }
}

extension Todo.Priority: DatabaseValueConvertible {}

extension Todo: Codable, Equatable, Identifiable {}

extension Todo: FetchableRecord, MutablePersistableRecord {
    mutating func didInsert(with rowID: Int64, for column: String?) {
        self.id = rowID
    }
}

extension Todo: TableRecord, EncodableRecord {
    static let subTodos = hasMany(SubTodo.self)
    
    var subTodos: QueryInterfaceRequest<SubTodo> {
        request(for: Todo.subTodos)
    }
}
