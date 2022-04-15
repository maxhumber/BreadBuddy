import Foundation

extension RecipeViewModel {
    func didChange(_ timeEnd: Date) {
        refresh()
    }
    
    func footerStartAction() {
        mode = .active
        recipe.isActive = true
        save()
    }
    
    func footerEditAction() {
        mode = .edit
    }
    
    func footerSaveAction() {
        mode = .display
        save()
    }
    
    func footerCancelAction() {
        mode = .display
        recipe.isActive = false
        save()
    }
    
    func footerRestartAction() {
        print("NOT IMPLEMENTED")
    }
}
