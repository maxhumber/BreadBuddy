import BBKit
import Combine
import Foundation

final class IndexViewModel: ObservableObject {
    private var repository: RecipeRepository
    
    @Published var recipes = [Recipe]()
    @Published var error: Error? = nil
    @Published var addViewIsPresented = false
    
    init(repository: RecipeRepository = GRDBRecipeRepository()) {
        self.repository = repository
        self.repository.observe(onError: { self.error = $0 }, onChange: { self.recipes = $0 })
    }
    
    func addButtonAction() {
        addViewIsPresented = true
    }
}
