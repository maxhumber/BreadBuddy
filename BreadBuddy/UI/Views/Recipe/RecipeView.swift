import Core
import CustomUI
import SwiftUI

struct RecipeView: View {
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    init(_ recipe: Recipe = .init(), mode: Mode = .edit, database: Database = .shared) {
        let repository = RecipeStore(database)
        let viewModel = ViewModel(recipe, mode: mode, repository: repository)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        layout
            .background(Color.background)
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
        .ignoresSafeArea(.keyboard)
        .dismissKeyboard()
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
