import GRDB

extension Database {
    static let preview: Database = {
        let writer = DatabaseQueue()
        return try! Database(writer)
    }()
}
