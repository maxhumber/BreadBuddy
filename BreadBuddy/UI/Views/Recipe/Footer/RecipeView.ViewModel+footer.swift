import Foundation

extension RecipeView.ViewModel {
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
        mode = .make
        save()
    }

    var footerSaveSystemImage: String {
        recipe.id == nil ? "checkmark" : "square.and.arrow.down"
    }
    
    var footerSaveLabel: String {
        recipe.id == nil ? "Done" : "Save"
    }
    
    func footerSaveAction() {
        recipe.steps = recipe.steps.filter { $0.timeValue != 0 }
        mode = .plan
        save()
        reforward()
    }
    
    func footerStopAction() {
        recipe.isActive = false
        mode = .plan
        save()
    }
    
    func footerResetAction() {
        reforward()
    }
}
