import SwiftUI

struct StepsView: View {
    @StateObject var viewModel: StepsViewModel
    
    init(recipe: Recipe, database: Database = .shared) {
        _viewModel = StateObject(wrappedValue: .init(recipe: recipe, database: database))
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationBarHidden(true)
        }
    }
    
    private var content: some View {
        VStack {
            Button {
                viewModel.save()
            } label: {
                Text("Add Step")
            }
            List($viewModel.recipe.steps) { $step in
                TextField("", text: $step.description)
                    .onSubmit {
                        viewModel.update()
                    }
            }
        }
    }
}
