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
