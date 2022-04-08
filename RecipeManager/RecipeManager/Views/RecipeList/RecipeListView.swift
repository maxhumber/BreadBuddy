import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel: RecipeListViewModel
    
    init(database: Database = .shared) {
        _viewModel = StateObject(wrappedValue: .init(database))
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
                Text("Add")
            }
            List($viewModel.recipes) { $recipe in
                NavigationLink {
                    StepsView(recipe: recipe, database: .shared)
                } label: {
                    HStack {
                        TextField("", text: $recipe.name)
                            .onSubmit {
                                viewModel.update(recipe)
                            }
                        Spacer()
                        Button {
                            viewModel.delete(recipe)
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .buttonStyle(.plain)
                        .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
