import Combine
import Foundation
import GRDB

struct Database {
    let writer: DatabaseWriter
    
    init(_ writer: DatabaseWriter) throws {
        self.writer = writer
        try migrator.migrate(writer)
    }
    
    var reader: DatabaseReader {
        writer
    }
}

extension Database {
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        migrator.registerMigration("v1") { db in
            try db.create(table: "recipe") { table in
                table.autoIncrementedPrimaryKey("id")
                table.column("name", .text).notNull()
                table.column("note", .text).notNull()
                table.column("steps", .blob).notNull()
                table.column("dateCreated", .datetime).notNull()
                table.column("dateModified", .datetime).notNull()
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
    func publisher() -> AnyPublisher<[Recipe], Error> {
        ValueObservation
            .tracking(Recipe.fetchAll)
            .publisher(in: reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
    
    func save(_ recipe: inout Recipe) async throws {
        recipe = try await writer.write { [recipe] db in
            try recipe.saved(db)
        }
    }
    
    func delete(_ recipe: Recipe) throws {
        guard let id = recipe.id else { return }
        Task {
            try await writer.write { db in
                _ = try Recipe.deleteOne(db, id: id)
            }
        }
    }
}
