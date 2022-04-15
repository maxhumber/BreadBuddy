import BBKit
import Combine
import GRDB

extension Recipe: FetchableRecord, MutablePersistableRecord {
    public mutating func didInsert(with rowID: Int64, for column: String?) {
        self.id = rowID
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
    
    func delete(_ recipe: Recipe) async throws {
        guard let id = recipe.id else { return }
        try await writer.write { db in
            _ = try Recipe.deleteOne(db, id: id)
        }
    }
}
