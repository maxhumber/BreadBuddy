import SwiftUI

struct HomeView: View {
    @State private var editMode: EditMode = .inactive
    @StateObject var viewModel: ViewModel

    init(database: Database = .shared) {
        let viewModel = ViewModel(database: database)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $viewModel.addViewIsPresented) {
            editMode = .inactive
        } content: {
            newStepsView
        }
    }
    
    private var newStepsView: some View {
        StepsView()
            .environment(\.editMode, $editMode)
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
    }
    
    private var header: some View {
        ZStack {
            HStack {
                Spacer()
                Button {
                    viewModel.addViewIsPresented = true
                    editMode = .active
                } label: {
                    Image(systemName: "plus")
                }
            }
            Text("BreadBuddy")
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

