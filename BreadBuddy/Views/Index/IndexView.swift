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
        Image("Logo")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .font(.title)
            .foregroundColor(.accent1)
            .padding()
            .padding(.top, 5)
    }
    
    private var xlist: some View {
        XList(spacing: 20) {
            content
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder private var content: some View {
        if viewModel.inProgressSectionIsDisplayed {
            divider(label: "In Progress")
            ForEach(viewModel.recipesInProgress) { recipe in
                makeInProgressRow(for: recipe)
            }
        }
        divider(label: "Recipes")
        ForEach(viewModel.recipes) { recipe in
            makeRecipeRow(for: recipe)
        }
    }
    
    private func divider(label: String) -> some View {
        Divider {
            Text(label.uppercased())
                .tracking(2)
                .font(.matter(.caption))
        }
        .padding(.horizontal)
        .foregroundColor(.accent1)
    }
    
    private var newButton: some View {
        Button {
            viewModel.addButtonAction()
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "plus")
                    .font(.body)
                Text("New")
                    .font(.matter(.caption2))
            }
        }
        .foregroundColor(.accent1)
        .frame(maxWidth: .infinity)
    }
    
    private func makeInProgressRow(for recipe: Recipe) -> some View {
        XListLink {
            RecipeView(recipe, mode: .display)
        } label: {
            HStack(alignment: .center, spacing: 20) {
                VStack(alignment: .leading, spacing: 6)  {
                    Text(recipe.name)
                        .font(.matter())
                        .foregroundColor(.text1)
                    Text("Wednesday - 3:30 pm")
                        .font(.matter(.caption, emphasis: .italic))
                        .foregroundColor(.text2)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 5) {
                    Text("1.5 hrs")
                        .font(.matter(emphasis: .bold))
                        .foregroundColor(.text1)
                    Text("till next step")
                        .font(.matter(.caption, emphasis: .italic))
                        .foregroundColor(.text2)
                }
            }
        }
    }
    
    private func makeRecipeRow(for recipe: Recipe) -> some View {
        XListLink {
            RecipeView(recipe, mode: .display)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(recipe.name)
                        .font(.matter())
                        .foregroundColor(.text1)
                    Text("15 hours")
                        .font(.matter(.caption, emphasis: .italic))
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

