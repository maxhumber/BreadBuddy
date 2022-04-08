import Foundation
import GRDB

struct SubTodo {
    var id: Int64?
    var todoId: Int64?
    var label: String
    var completed: Bool
    var dateCreated: Date?
    var dateModified: Date?
}

extension SubTodo {
    init(todoId: Int64, label: String, completed: Bool, dateCreated: Date) {
        self.todoId = todoId
        self.label = label
        self.completed = completed
        self.dateCreated = dateCreated
        self.dateModified = dateCreated
    }
}

extension SubTodo: Identifiable, Codable, Equatable {}

extension SubTodo: FetchableRecord, MutablePersistableRecord {
    mutating func didInsert(with rowID: Int64, for column: String?) {
        self.id = rowID
    }
}

extension SubTodo: TableRecord, EncodableRecord {
    static let todo = belongsTo(Todo.self)
    
    var todo: QueryInterfaceRequest<Todo> {
        request(for: SubTodo.todo)
    }
}
