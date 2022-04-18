import BBKit

protocol RecipeRepository {
    func save(_ recipe: Recipe) async throws -> Recipe
    func delete(_ recipe: Recipe) async throws -> Bool
    func observe(onError: @escaping (Error) -> (), onChange: @escaping ([Recipe]) -> ())
}
