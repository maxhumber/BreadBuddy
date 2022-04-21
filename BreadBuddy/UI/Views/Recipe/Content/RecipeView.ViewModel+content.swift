import Core

extension RecipeView.ViewModel {
    func doubleTapAction() {
        mode = .edit
    }
    
    func didChange(to field: EditStepField?, with mode: EditStepMode) {
        if field == .none && mode == .new && newStep.isValid {
            recipe.steps.append(newStep)
            newStep = .init()
        }
    }
    
    func delete(_ step: Step) {
        if let index = recipe.steps.firstIndex(of: step) {
            recipe.steps.remove(at: index)
        }
    }
    
    func insert(_ step: Step, after: Bool = false) {
        if var index = recipe.steps.firstIndex(of: step) {
            if after {
                index = recipe.steps.index(after: index)
            }
            recipe.steps.insert(.init(), at: index)
        }
    }
}
