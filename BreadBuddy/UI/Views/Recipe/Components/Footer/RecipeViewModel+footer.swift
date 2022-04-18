import Foundation

extension RecipeViewModel {
    func didChange(_ timeEnd: Date) {
        refresh()
    }
    
    var footerUnderlinePickers: Bool {
        mode == .edit
    }
    
    var footerPickersAreDisabled: Bool {
        mode != .edit
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
        regroup()
    }
    
    func footerCancelAction() {
        recipe.isActive = false
        mode = .display
        save()
    }
    
    func footerRestartAction() {
        reforward()
    }
}
