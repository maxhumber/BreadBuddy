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
    
    var headerViewLinkButtonIsDisplayed: Bool {
        let isNotNil = !(recipe.link == nil)
        let isNotEmpty = !(recipe.link != "")
        return isNotEmpty && isNotNil
    }
    
    var headerLinkButtonIsDisabled: Bool {
        if mode == .edit {
            return false
        } else {
            return !(recipe.link?.isValidURL == true)
        }
    }
    
    var headerRecipeURL: URL? {
        guard let link = recipe.link else { return nil }
        return URL(string: link)
    }
    
    func headerLinkButtonAction() {
        urlTextAlertIsPresented = true
    }
}
