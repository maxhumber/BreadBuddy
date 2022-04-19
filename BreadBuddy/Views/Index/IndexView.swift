import Core
import CustomUI
import SwiftUI

struct XList<Content: View>: View {
    @ViewBuilder var content: () -> Content
    
    init() {
        
    }
    
    var body: some View {
        Text("I hate List")
    }
}

struct IndexView: View {
    @StateObject var viewModel: IndexViewModel

    init(repository: RecipeRepository = GRDBRecipeRepository()) {
        let viewModel = IndexViewModel(repository: repository)
        _viewModel = StateObject(wrappedValue: viewModel)
        // UIKit BS
        UITableView.appearance().backgroundColor = UIColor(.clear)
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            newStatic
                .environmentObject(viewModel)
        }
    }
    
    private var newStatic: some View {
        VStack(alignment: .leading, spacing: 20) {
            logo
            List {
                Group {
                    if viewModel.inProgressSectionIsDisplayed {
                        Divider("In Progress".uppercased())
                            .padding(.horizontal)
                        ForEach(viewModel.recipesInProgress) { recipe in
                            makeInProgressRow(for: recipe)
                        }
                    }
                    Divider("Recipes".uppercased())
                        .padding(.horizontal)
                    ForEach(viewModel.recipes) { recipe in
                        makeRecipeRow(for: recipe)
                    }
                    newButton
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(Color.clear)
            }
            .listStyle(InsetListStyle())
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $viewModel.addViewIsPresented) {
            RecipeView()
        }
    }
    
    func makeInProgressRow(for recipe: Recipe) -> some View {
        ZStack {
            //Create a NavigationLink without the disclosure indicator
            NavigationLink(destination: Text("Hello, World!")) {
                EmptyView()
            }
            
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
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    func makeRecipeRow(for recipe: Recipe) -> some View {
        ZStack {
            //Create a NavigationLink without the disclosure indicator
            NavigationLink(destination: RecipeView(recipe, mode: .display)) {
                EmptyView()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(recipe.name)
                    Text("15 hours")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .contentShape(Rectangle())
        }
    }
    
    private var logo: some View {
        Image(systemName: "timelapse")
            .font(.title)
            .frame(maxWidth: .infinity)
            .foregroundColor(.secondary)
    }
    
    private var newButton: some View {
        Button {
            viewModel.addButtonAction()
        } label: {
            Text("New".uppercased())
                .font(.caption)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondary, style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [3]))
                )
                .padding(.horizontal)
                .foregroundColor(.secondary)
        }
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}

