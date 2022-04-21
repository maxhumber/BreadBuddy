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
    
    var headerRecipeURL: URL? {
        guard let link = recipe.link else { return nil }
        return URL(string: link)
    }
    
    var headerLinkButtonIsDisplayed: Bool {
        return !(recipe.link?.isValidURL == true)
    }
    
    var headerLinkButtonIsDisabled: Bool {
        if mode == .edit {
            return false
        } else {
            return !(recipe.link?.isValidURL == true)
        }
    }
}
