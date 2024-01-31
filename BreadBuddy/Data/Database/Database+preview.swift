import GRDB

extension Database {
    static let preview: Database = {
        let writer = try! DatabaseQueue()
        return try! Database(writer)
    }()
}
