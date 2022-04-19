import BreadKit
import SwiftUI

struct IndexView: View {
    @StateObject var viewModel: IndexViewModel

    init(repository: RecipeRepository = GRDBRecipeRepository()) {
        let viewModel = IndexViewModel(repository: repository)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            layersOld
        }
        .environmentObject(viewModel)
    }
    
    private var newStatic: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image(systemName: "circle")
                .font(.title)
                .frame(maxWidth: .infinity)
            Divider("In Progress".uppercased())
            HStack(alignment: .center, spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Next step")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("1.5 hrs")

                }
                VStack(alignment: .leading, spacing: 5)  {
                    Text("Wednesday • 3:30 pm")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("No-Knead Sourdough")

                }
                Spacer()
            }
            Divider("Recipes".uppercased())
            VStack(alignment: .leading, spacing: 5) {
                Text("No-Knead Sourdough")
                Text("15 hours")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("No-Knead Sourdough")
                Text("15 hours")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Text("New Recipe")
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondary, style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [3]))
                )
                .padding()
            Spacer()
        }
        .padding(20)
        .navigationBarHidden(true)
    }
    
    private var layersOld: some View {
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
            VStack(alignment: .leading, spacing: 0) {
                Text(recipe.name)
                Text(recipe.totalTime)
                    .font(.caption)
            }
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

