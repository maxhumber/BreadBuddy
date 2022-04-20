import Core
import GRDB

extension Database {
    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        migrator.registerMigration("v1") { db in
            try createRecipeTable(db)
            try seedRecipeTable(db)
        }
        return migrator
    }
    
    private func createRecipeTable(_ db: GRDB.Database) throws {
        try db.create(table: "recipe") { table in
            table.autoIncrementedPrimaryKey("id")
            table.column("name", .text).notNull()
            table.column("link", .text)
            table.column("timeEnd", .datetime).notNull()
            table.column("steps", .blob).notNull()
            table.column("isActive", .boolean).notNull()
        }
    }
    
    @discardableResult private func seedRecipeTable(_ db: GRDB.Database) throws -> Recipe {
        try Recipe.preview.saved(db)
    }
}
