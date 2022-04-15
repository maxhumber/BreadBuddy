import SwiftUI

struct RecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: RecipeViewModel
    
    init(recipe: Recipe = .init(), mode: RecipeMode = .display, database: Database = .shared) {
        let viewModel = RecipeViewModel(recipe: recipe, mode: mode, database: database)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        layout
            .environmentObject(viewModel)
            .onAppear(perform: viewModel.didAppear)
            .onChange(of: viewModel.recipe.timeEnd) { timeEnd in
                viewModel.didChange(timeEnd: timeEnd)
            }
    }
    
    private var layout: some View {
        VStack(spacing: 10) {
            header
            content
            footer
        }
        .navigationBarHidden(true)
        .dismissKeyboard()
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: .preview, mode: .display)
        RecipeView(recipe: .preview, mode: .edit)
        RecipeView(recipe: .preview, mode: .active)
    }
}
