import Foundation
import Combine

@MainActor final class RecipesViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    private let database: Database
    private var cancellables = Set<AnyCancellable>()
    
    init(_ database: Database = .shared) {
        self.database = database
        database.publisher()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { recipes in
                self.recipes = recipes
            }
            .store(in: &cancellables)
    }
    
    func save() {
        Task {
            let name = "Recipe: \(String(UUID().uuidString.prefix(6)))"
            var recipe = Recipe(name: name, note: "", steps: [])
            try await database.save(&recipe)
        }
    }
    
    func update(_ recipe: Recipe) {
        Task {
            var recipe = recipe
            recipe.dateModified = Date()
            try await database.save(&recipe)
        }
    }
    
    func delete(_ recipe: Recipe) {
        Task {
            try await database.delete(recipe)
        }
    }
}

