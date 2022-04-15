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
        .padding()
        .background(.green.opacity(0.2)) // debug
    }
    
    @ViewBuilder private var leadingButton: some View {
        switch viewModel.mode {
        case .display:
            makeButton("Start", systemImage: "clock") {
                viewModel.footerStartAction()
            }
        case .edit:
            EmptyView() // XXX
        case .active:
            makeButton("Cancel", systemImage: "xmark.circle", action: viewModel.footerCancelAction)
        }
    }
    
    @ViewBuilder private var trailingButton: some View {
        switch viewModel.mode {
        case .display:
            makeButton("Edit", systemImage: "pencil", action: viewModel.footerEditAction)
        case .edit:
            makeButton("Save", systemImage: "square.and.arrow.down", action: viewModel.footerSaveAction)
        case .active:
            makeButton("Restart", systemImage: "clock.arrow.circlepath", action: viewModel.footerRestartAction)
        }
    }
    
    private func makeButton(_ label: String, systemImage: String, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            VStack(spacing: 10) {
                Image(systemName: systemImage)
                    .font(.title2)
                Text(label)
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
}

struct RecipeView_Footer_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: .preview, mode: .display)
        RecipeView(recipe: .preview, mode: .edit)
        RecipeView(recipe: .preview, mode: .active)
    }
}
