import Foundation
import GRDB

extension Database {
    static let shared: Database = {
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
    }()
}
