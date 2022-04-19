import Core
import GRDB

class GRDBRecipeRepository: RecipeRepository {
    private let database: Database
    private var cancellable: DatabaseCancellable?
    
    init(_ database: Database = .shared) {
        self.database = database
    }
    
    func save(_ recipe: Recipe) async throws -> Recipe {
        try await database.writer.write { db in
            return try recipe.saved(db)
        }
    }
    
    @discardableResult func delete(_ recipe: Recipe) async throws -> Bool {
        try await database.writer.write { db in
            guard let id = recipe.id else { return false }
            return try Recipe.deleteOne(db, id: id)
        }
    }
    
    func observe(onError: @escaping (Error) -> (), onChange: @escaping ([Recipe]) -> ()) {
        let observation = ValueObservation.tracking(Recipe.fetchAll)
        cancellable = observation.start(in: database.reader, onError: onError, onChange: onChange)
    }
}
