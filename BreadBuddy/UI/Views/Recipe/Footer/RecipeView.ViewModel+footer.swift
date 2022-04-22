import Foundation

extension RecipeView.ViewModel {
    var discardButtonIsDislayed: Bool {
        recipe.id != nil
    }
    
    var doneButtonIsDisabled: Bool {
        recipe.name.isEmpty || recipe.steps.isEmpty
    }
}
