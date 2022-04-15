import Foundation

extension RecipeViewModel {
    @MainActor func footerStartAction() {
        recipe.isActive = true
        save()
        mode = .active
    }
    
    func footerEditAction() {
        mode = .edit
    }
    
    @MainActor func footerSaveAction() {
        save()
        mode = .display
    }
    
    @MainActor func footerCancelAction() {
        recipe.isActive = false
        save()
        mode = .display
    }
    
    func footerRestartAction() {
        
    }
}
