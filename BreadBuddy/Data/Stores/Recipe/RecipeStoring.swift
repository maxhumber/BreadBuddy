import Core

protocol RecipeStoring {
    func fetch() async throws -> [Recipe]
    func save(_ recipe: Recipe) async throws -> Recipe
    @discardableResult func delete(_ recipe: Recipe) async throws -> Bool
}
