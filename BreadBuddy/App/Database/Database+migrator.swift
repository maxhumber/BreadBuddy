import Foundation
import GRDB

extension Database {
    var migrator: DatabaseMigrator {
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
