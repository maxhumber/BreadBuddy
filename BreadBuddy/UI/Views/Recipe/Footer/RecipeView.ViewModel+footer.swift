import Foundation

extension RecipeView.ViewModel {
    var discardButtonIsDislayed: Bool {
        recipe.id != nil
    }
    
    
    ///
    
    var saveButtonIsDisabled: Bool {
        recipe.steps.isEmpty || recipe.name.isEmpty
    }
    
    var cancelEditButtonIsDisplayed: Bool {
        recipe.steps.isEmpty || recipe.name.isEmpty
    }

    var footerSaveSystemImage: String {
        recipe.id == nil ? "checkmark" : "square.and.arrow.down"
    }
    
    var footerSaveLabel: String {
        recipe.id == nil ? "Done" : "Save"
    }
}
