import Core
import CustomUI
import SwiftUI

struct IndexView: View {
    @StateObject var viewModel: ViewModel

    init(database: Database = .shared) {
        let repository = RecipeStore(database)
        let viewModel = ViewModel(repository: repository)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            layout
                .background(Color.background)
                .environmentObject(viewModel)
                .onAppear {
                    viewModel.didAppear()
                }
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
            viewModel.didAppear()
        } content: {
            RecipeView()
        }
    }
    
    private var header: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.top, 5)
    }
    
    @ViewBuilder private var xlist: some View {
        if viewModel.emptyContentIsDisplayed {
            emptyContent
        } else {
            XList(spacing: 20) {
                xlistContent
                    .padding(.horizontal)
            }
        }
    }
    
    private var emptyContent: some View {
        VStack(spacing: 0) {
            Text("No saved recipes...")
                .padding()
            Spacer()
            Text("...tap to add a new one!")
                .padding()
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(.accent2)
        .font(.matter(.body))
    }
    
    @ViewBuilder private var xlistContent: some View {
        if viewModel.inProgressSectionIsDisplayed {
            divider(label: "In Progress")
            ForEach(viewModel.recipesInProgress) { recipe in
                makeRecipeRow(for: recipe)
            }
        }
        if viewModel.recipeDividerIsDisplayed {
            divider(label: "Recipes")
        }
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
            HStack(spacing: 10) {
                Image(systemName: "plus")
                    .font(.body)
                Text("New")
                    .font(.matter(.caption))
            }
            .padding()
        }
        .buttonStyle(StrokedButtonStyle())
        .padding()
        .padding(.horizontal)
        .foregroundColor(.accent1)
    }
    
    private func makeRecipeRow(for recipe: Recipe) -> some View {
        XListLink {
            RecipeView(recipe, mode: .plan)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.matter())
                        .foregroundColor(.text1)
                    Text(viewModel.subtitle(for: recipe))
                        .font(.matter(.caption2, emphasis: .italic))
                        .foregroundColor(.text2)
                }
                Spacer()
            }
        }
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView(database: .shared)
        IndexView(database: .preview)
    }
}

