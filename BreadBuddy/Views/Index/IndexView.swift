import Core
import CustomUI
import SwiftUI

struct IndexView: View {
    @StateObject var viewModel: IndexViewModel

    init(repository: RecipeRepository = GRDBRecipeRepository()) {
        let viewModel = IndexViewModel(repository: repository)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            layout
                .background(Color.background)
                .environmentObject(viewModel)
        }
    }
    
    private var layout: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            xlist
            newButton
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $viewModel.addViewIsPresented) {
            RecipeView()
        }
    }
    
    private var header: some View {
        Image(systemName: "timelapse")
            .font(.title)
            .frame(maxWidth: .infinity)
            .foregroundColor(.accent2)
            .padding()
    }
    
    private var xlist: some View {
        XList(spacing: 20) {
            content
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder private var content: some View {
        if viewModel.inProgressSectionIsDisplayed {
            Divider("In Progress")
                .padding(.horizontal)
                .font(.body)
                .foregroundColor(.accent1)
            ForEach(viewModel.recipesInProgress) { recipe in
                makeInProgressRow(for: recipe)
            }
        }
        Divider("Recipes")
            .padding(.horizontal)
            .font(.body)
            .foregroundColor(.accent1)
        ForEach(viewModel.recipes) { recipe in
            makeRecipeRow(for: recipe)
        }
    }
    
    private var newButton: some View {
        Button {
            viewModel.addButtonAction()
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "plus")
                    .font(.body)
                Text("New")
                    .font(.caption)
            }
            .foregroundColor(.accent1)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func makeInProgressRow(for recipe: Recipe) -> some View {
        XListLink {
            RecipeView(recipe, mode: .display)
        } label: {
            HStack(alignment: .center, spacing: 20) {
                VStack(alignment: .leading, spacing: 5)  {
                    Text(recipe.name)
                    Text("Wednesday • 3:30 pm")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 5) {
                    Text("1.5 hrs")
                        .font(.body.bold())
                    Text("till next step")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private func makeRecipeRow(for recipe: Recipe) -> some View {
        XListLink {
            RecipeView(recipe, mode: .display)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(recipe.name)
                        .font(.body)
                        .foregroundColor(.text1)
                    Text("15 hours")
                        .font(.caption)
                        .foregroundColor(.text2)
                }
                Spacer()
            }
        }
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}

