import Combine
import Foundation
import GRDB

struct Database {
    private let writer: DatabaseWriter
    
    init(_ writer: DatabaseWriter) throws {
        self.writer = writer
        try migrator.migrate(writer)
    }
    
    private var reader: DatabaseReader {
        writer
    }
}

extension Database {
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        migrator.registerMigration("createTodo") { db in
            try db.create(table: "todo") { table in
                table.autoIncrementedPrimaryKey("id")
                table.column("label", .text).notNull()
                table.column("completed", .boolean).notNull()
            }
        }
        return migrator
    }
}

extension Database {
    static let shared = makeShared()
    
    private static func makeShared() -> Database {
        do {
            let fileManager = FileManager()
            let folder = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("database", isDirectory: true)
            if CommandLine.arguments.contains("-reset") {
                try? fileManager.removeItem(at: folder)
            }
            try fileManager.createDirectory(at: folder, withIntermediateDirectories: true)
            let url = folder.appendingPathComponent("db.sqlite")
            let writer = try DatabasePool(path: url.path)
            let database = try Database(writer)
            return database
        } catch {
            fatalError("Unresolved error: \(error)")
        }
    }
    
    static func empty() -> Database {
        let writer = DatabaseQueue()
        return try! Database(writer)
    }
}

extension Database {
    func save(_ todo: inout Todo) async throws {
        todo = try await writer.write { [todo] db in
            try todo.saved(db)
        }
    }
    
    func update(_ todo: Todo) async throws {
        try await writer.write { [todo] db in
            _ = try todo.saved(db)
        }
    }
    
    func todoPublisher() -> AnyPublisher<[Todo], Error> {
        ValueObservation.tracking(Todo.fetchAll)
            .publisher(in: reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
    
    func delete(_ todo: Todo) async throws {
        guard let id = todo.id else { return }
        try await writer.write { db in
            _ = try Todo.deleteAll(db, ids: [id])
        }
    }
}
