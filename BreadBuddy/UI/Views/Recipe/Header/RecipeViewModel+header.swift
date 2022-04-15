import Foundation

extension RecipeViewModel {
    var headerBackButtonIsDisplayed: Bool {
        mode != .edit
    }
    
    var headerNameFieldIsDisabled: Bool {
        mode != .edit
    }
    
    var headerNameFieldUnderscoreIsHidden: Bool {
        mode != .edit
    }
    
    var headerDeleteButtonIsDisplayed: Bool {
        mode == .edit
    }
    
    func headerDeleteButtonAction() {
        deleteAlertIsPresented = true
    }
    
    func deleteRecipe() {
        Task(priority: .userInitiated) {
            try? await database.delete(recipe)
        }
    }
}
