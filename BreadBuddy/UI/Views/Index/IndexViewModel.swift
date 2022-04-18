import BBKit
import Combine
import Foundation

final class IndexViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var addViewIsPresented = false
    private var repository: RecipeRepository
    
    init(repository: RecipeRepository = GRDBRecipeRepository()) {
        self.repository = repository
        self.repository.observe { recipes in
            self.recipes = recipes
        } onError: { _ in
            self.recipes = []
        }
    }
    
    func addButtonAction() {
        addViewIsPresented = true
    }
}
