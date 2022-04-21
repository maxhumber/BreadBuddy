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
    
    func headerLinkButtonAction() {
        urlTextAlertIsPresented = true
    }
    
    var headerLinkButtonIsDisabled: Bool {
        if mode == .edit {
            return false
        } else {
            return recipe.link == nil
        }
    }
    
    var headerRecipeURL: URL? {
        guard let link = recipe.link else { return nil }
        return URL(string: link)
    }
}