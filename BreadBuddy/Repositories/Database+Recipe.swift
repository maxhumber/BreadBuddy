import BBKit
import Combine
import GRDB

extension Recipe: FetchableRecord, MutablePersistableRecord {
    public mutating func didInsert(with rowID: Int64, for column: String?) {
        self.id = rowID
    }
}

protocol RecipeRepository {
    func publisher() -> AnyPublisher<[Recipe], Error>
    func observe(onChange: @escaping ([Recipe]) -> (), onError: @escaping (Error) -> ())
    func save(_ recipe: Recipe) async throws -> Recipe
    func delete(_ recipe: Recipe) async throws -> Bool
}

class GRDBRecipeRepository: RecipeRepository {
    private let database: Database
    private var cancellable: DatabaseCancellable?
    
    init(_ database: Database = .shared) {
        self.database = database
    }
    
    func publisher() -> AnyPublisher<[Recipe], Error> {
        ValueObservation
            .tracking(Recipe.fetchAll)
            .publisher(in: database.reader, scheduling: .immediate)
            .eraseToAnyPublisher()
    }
    
    func observe(onChange: @escaping ([Recipe]) -> (), onError: @escaping (Error) -> ()) {
        let observation = ValueObservation.tracking(Recipe.fetchAll)
        cancellable = observation.start(in: database.reader, onError: onError, onChange: onChange)
    }
    
    func save(_ recipe: Recipe) async throws -> Recipe {
        try await database.writer.write { db in
            return try recipe.saved(db)
        }
    }
    
    @discardableResult
    func delete(_ recipe: Recipe) async throws -> Bool {
        try await database.writer.write { db in
            guard let id = recipe.id else { return false }
            return try Recipe.deleteOne(db, id: id)
        }
    }
}



//extension Database {
//    func publisher() -> AnyPublisher<[Recipe], Error> {
//        ValueObservation
//            .tracking(Recipe.fetchAll)
//            .publisher(in: reader, scheduling: .immediate)
//            .eraseToAnyPublisher()
//    }
//
//    func save(_ recipe: inout Recipe) async throws {
//        recipe = try await writer.write { [recipe] db in
//            try recipe.saved(db)
//        }
//    }
//
//    func delete(_ recipe: Recipe) async throws {
//        guard let id = recipe.id else { return }
//        try await writer.write { db in
//            _ = try Recipe.deleteOne(db, id: id)
//        }
//    }
//}
