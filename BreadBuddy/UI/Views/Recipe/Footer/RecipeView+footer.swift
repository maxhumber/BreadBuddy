import SwiftUI

extension RecipeView {
    var footer: some View {
        HStack(spacing: 0) {
            ZStack {
                Color.clear.fixedSize(horizontal: false, vertical: true)
                leadingButton
            }
            ZStack {
                Color.clear.fixedSize(horizontal: false, vertical: true)
                trailingButton
            }
        }
        .foregroundColor(.black)
        .padding()
        .background(.green.opacity(0.2)) // debug
    }
    
    @ViewBuilder private var leadingButton: some View {
        switch viewModel.mode {
        case .display: displayLeadingButton
        case .edit: editLeadingButton
        case .active: activeLeadingButton
        }
    }
    
    private var displayLeadingButton: some View {
        Button {
            viewModel.recipe.isActive = true
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "clock")
                    .font(.title2)
                Text("Start")
                    .font(.body)
            }
        }
    }
    
    private var editLeadingButton: some View {
        Button {
            
        } label: {
            VStack(spacing: 10) {
                Text("6:00 pm")
                    .font(.title2)
                Text("Friday")
                    .font(.body)
            }
        }
    }
    
    private var activeLeadingButton: some View {
        Button {
            viewModel.recipe.isActive = false
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "xmark.circle")
                    .font(.title2)
                Text("Cancel")
                    .font(.body)
            }
        }
    }
    
    @ViewBuilder private var trailingButton: some View {
        switch viewModel.mode {
        case .display: displayTrailingButton
        case .edit: editTrailingButton
        case .active: activeTrailingButton
        }
    }
    
    private var displayTrailingButton: some View {
        Button {
            viewModel.mode = .edit
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "pencil")
                    .font(.title2)
                Text("Edit")
                    .font(.body)
            }
        }
    }
    
    private var editTrailingButton: some View {
        Button {
            viewModel.mode = .display
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "square.and.arrow.down")
                    .font(.title2)
                Text("Save")
                    .font(.body)
            }
        }
    }
    
    private var activeTrailingButton: some View {
        Button {
            viewModel.recipe.isActive = false
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.title2)
                Text("Restart")
                    .font(.body)
            }
        }
    }
}

struct RecipeView_Footer_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: .preview, mode: .display)
        RecipeView(recipe: .preview, mode: .edit)
        RecipeView(recipe: .preview, mode: .active)
    }
}
