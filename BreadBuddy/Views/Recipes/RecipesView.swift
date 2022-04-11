import SwiftUI

struct RecipesView: View {
    @StateObject var viewModel: RecipesViewModel
    @State var addViewIsPresented = false
    
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
            header
            List($viewModel.recipes) { $recipe in
                NavigationLink {
                    StepsView(recipe: recipe)
                } label: {
                    Text(recipe.name)
                }
            }
            .listStyle(.plain)
        }
        .fullScreenCover(isPresented: $addViewIsPresented) {
            StepsView(recipe: Recipe())
        }
    }
    
    private var header: some View {
        ZStack {
            HStack {
                Spacer()
                Button {
                    addViewIsPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            Text("Recipes")
        }
        .padding()
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}

