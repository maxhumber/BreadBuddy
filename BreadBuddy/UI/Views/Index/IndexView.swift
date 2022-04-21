import Core
import CustomUI
import SwiftUI

struct IndexView: View {
    @StateObject var viewModel: ViewModel

    init(_ database: Database = .persistent) {
        let viewModel = ViewModel(store: RecipeStore(database))
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                header
                xlist
                newButton
            }
            .background(Color.background)
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.refresh()
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
        VStack {
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
            divider("In Progress")
            ForEach(viewModel.recipesInProgress) { recipe in
                recipeRow(recipe)
            }
        }
        if viewModel.recipeDividerIsDisplayed {
            divider("Recipes")
        }
        ForEach(viewModel.recipes) { recipe in
            recipeRow(recipe)
        }
    }
    
    private func divider(_ label: String) -> some View {
        Divider {
            Text(label.uppercased())
                .tracking(2)
                .font(.matter(.caption))
        }
        .padding(.horizontal)
        .foregroundColor(.accent1)
    }
    
    private func recipeRow(_ recipe: Recipe) -> some View {
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
    
    private var newButton: some View {
        FullScreenCoveringButton {
            RecipeView()
        } onDismiss: {
            viewModel.refresh()
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
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView(.persistent)
        IndexView(.preview)
    }
}

