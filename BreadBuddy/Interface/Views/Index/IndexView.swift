import Sugar
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
                content
                footer
            }
            .font(.matter(.caption))
            .foregroundColor(.accent1)
            .background(Color.background)
            .navigationBarHidden(true)
        }
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
        Group {
            if viewModel.recipesLimitReached {
                alertingButton
            } else {
                coveringButton
            }
        }
        .padding()
        .padding(.horizontal)
        .padding(.leading, -2)
    }
    
    private var coveringButton: some View {
        CoveringButton {
            RecipeView(.init(), mode: .edit)
        } onDismiss: {
            viewModel.refresh()
        } label: {
            newButtonLabel
        }
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
    }
    
    private var alertingButton: some View {
        AlertingButton {
            Alert(
                title: Text("Limit Reached"),
                message: Text("Unable to add more than five recipes at this time")
            )
        } label: {
            newButtonLabel
        }
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
    }
    
    private var newButtonLabel: some View {
        HStack {
            Image(systemName: "plus")
            Text("New")
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView(.persistent)
        IndexView(.preview)
    }
}

