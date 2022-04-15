import Foundation
import GRDB

extension Database {
    static let empty: Database = {
        let writer = DatabaseQueue()
        return try! Database(writer)
    }()
}
