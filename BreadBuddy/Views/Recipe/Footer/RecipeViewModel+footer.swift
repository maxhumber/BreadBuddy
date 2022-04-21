import Foundation

extension RecipeViewModel {
    var saveButtonIsDisabled: Bool {
        recipe.steps.isEmpty || recipe.name.isEmpty
    }
    
    var cancelEditButtonIsDisplayed: Bool {
        recipe.steps.isEmpty || recipe.name.isEmpty
    }
    
    func didChange(_ timeEnd: Date) {
        refresh()
    }
    
    func footerStartAction() {
        recipe.isActive = true
        mode = .active
        save()
    }
    
    func footerEditAction() {
        mode = .edit
    }
    
    func footerDeleteButtonAction() {
        deleteAlertIsPresented = true
    }
    
    func alertDeleteAction() {
        delete()
    }
    
    func footerSaveAction() {
        recipe.steps = recipe.steps.filter { $0.timeValue != 0 }
        mode = .display
        save()
        reforward()
    }
    
    func footerQuitAction() {
        recipe.isActive = false
        mode = .display
        save()
    }
    
    func footerRestartAction() {
        reforward()
    }
}
