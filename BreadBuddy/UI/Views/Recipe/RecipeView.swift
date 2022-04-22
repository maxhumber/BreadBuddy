import Core
import CustomUI
import SwiftUI

struct RecipeView: View {
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    init(_ recipe: Recipe, mode: Mode, database: Database = .persistent) {
        let viewModel = ViewModel(recipe, mode: mode, store: RecipeStore(database))
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            header
            content
            footer
        }
        .background(Color.background)
        .environmentObject(viewModel)
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard)
        .dismissKeyboard()
        .onAppear { viewModel.didAppear() }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .plan, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.init(), mode: .edit, database: .preview)
        RecipeView(.preview, mode: .make, database: .preview)
    }
}
