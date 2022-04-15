import SwiftUI

struct RecipeView: View {
    @StateObject var viewModel: RecipeViewModel
    @Environment(\.dismiss) var dismiss
    
    init(_ recipe: Recipe = .init(), mode: RecipeMode = .edit, database: Database = .shared) {
        let viewModel = RecipeViewModel(recipe, mode: mode, database: database)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        layout
            .environmentObject(viewModel)
            .onAppear {
                viewModel.didAppear()
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
        RecipeView(.preview, mode: .display, database: .empty())
        RecipeView(.preview, mode: .edit, database: .empty())
        RecipeView(.preview, mode: .active, database: .empty())
    }
}
