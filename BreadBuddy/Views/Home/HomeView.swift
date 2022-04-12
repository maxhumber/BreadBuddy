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
        ZStack {
            VStack {
                header
                List($viewModel.recipes) { $recipe in
                    NavigationLink {
                        StepsView(recipe: recipe)
                    } label: {
                        Text(recipe.name)
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                            viewModel.deleteAlertIsPresented = true
                        } label: {
                            Label("Delete", systemImage: "xmark")
                        }
                    }
                    .alert(isPresented: $viewModel.deleteAlertIsPresented) {
                        Alert(
                            title: Text("Delete Recipe"),
                            message: Text("Are you sure you want to delete this recipe?"),
                            primaryButton: .destructive(Text("confirm")) {
                                viewModel.delete(recipe)
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .listStyle(.plain)
            }
            floatingAddButton
        }
    }
    
    private var floatingAddButton: some View {
        Button {
            viewModel.addViewIsPresented = true
            editMode = .active
        } label: {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .font(.title3)
                .padding()
                .background(
                    Circle()
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 1)
                )
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    private var header: some View {
        ZStack {
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

