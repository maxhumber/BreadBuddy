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
                table.column("timeEnd", .datetime).notNull()
                table.column("steps", .blob).notNull()
                table.column("isActive", .boolean).notNull()
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
