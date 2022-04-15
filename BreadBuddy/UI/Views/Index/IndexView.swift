import SwiftUI

struct IndexView: View {
    @StateObject var viewModel: IndexViewModel

    init(database: Database = .shared) {
        let viewModel = IndexViewModel(database: database)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            layers
        }
        .environmentObject(viewModel)
    }
    
    private var layers: some View {
        ZStack {
            content
            addButton
        }
        .navigationBarHidden(true)
    }
    
    private var content: some View {
        VStack {
            header
            list
        }
        .fullScreenCover(isPresented: $viewModel.addViewIsPresented) {
            RecipeView()
        }
    }
    
    private var header: some View {
        ZStack {
            Text("BreadBuddy")
        }
        .padding()
    }
    
    private var list: some View {
        List(viewModel.recipes) { recipe in
            row(for: recipe)
        }
        .listStyle(.plain)
    }

    private func row(for recipe: Recipe) -> some View {
        NavigationLink {
            RecipeView(recipe, mode: .display)
        } label: {
            Text(recipe.name)
        }
    }
    
    private var addButton: some View {
        Button {
            viewModel.addButtonAction()
        } label: {
            addButtonContent
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    private var addButtonContent: some View {
        Image(systemName: "plus")
            .foregroundColor(.white)
            .font(.title3)
            .padding()
            .background(addButtonBackground)
            .padding()
    }
    
    private var addButtonBackground: some View {
        Circle()
            .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 1)
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}

