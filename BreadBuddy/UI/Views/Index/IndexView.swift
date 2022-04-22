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
                content
                footer
            }
            .font(.matter(.caption))
            .foregroundColor(.accent1)
            .background(Color.background)
            .navigationBarHidden(true)
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
    
    @ViewBuilder private var content: some View {
        if viewModel.emptyContentIsDisplayed {
            emptyContent
        } else {
            populatedContent
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
    
    private var populatedContent: some View {
        StealthList(spacing: 20) {
            activeSection
            inactiveSection
        }
    }
    
    @ViewBuilder var activeSection: some View {
        if viewModel.activeSectionIsDisplayed {
            divider("In Progress")
            ForEach(viewModel.activeRecipes) { recipe in
                Row(recipe) {
                    viewModel.refresh()
                }
            }
        }
    }
    
    @ViewBuilder var inactiveSection: some View {
        if viewModel.recipeDividerIsDisplayed {
            divider("Recipes")
        }
        ForEach(viewModel.inactiveRecipes) { recipe in
            Row(recipe) {
                viewModel.refresh()
            }
        }
    }
    
    private func divider(_ label: String) -> some View {
        Divider {
            Text(label.uppercased()).tracking(2)
        }
        .padding(.horizontal)
    }
    
    private var footer: some View {
        CoveringButton {
            RecipeView(.init(), mode: .edit)
        } onDismiss: {
            viewModel.refresh()
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("New")
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
        .padding()
        .padding(.horizontal)
        .padding(.leading, -2)
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView(.persistent)
        IndexView(.preview)
    }
}

