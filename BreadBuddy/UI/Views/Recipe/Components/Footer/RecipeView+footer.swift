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
        .background(.green.opacity(0.2)) // DEBUG
    }
    
    @ViewBuilder private var leadingButton: some View {
        switch viewModel.mode {
        case .display:
            makeButton("Start", systemImage: "clock") {
                viewModel.footerStartAction()
            }
        case .edit:
            pickers
        case .active:
            makeButton("Cancel", systemImage: "xmark.circle") {
                viewModel.footerCancelAction()
            }
        }
    }
    
    @ViewBuilder private var trailingButton: some View {
        switch viewModel.mode {
        case .display:
            makeButton("Edit", systemImage: "pencil") {
                viewModel.footerEditAction()
            }
        case .edit:
            makeButton("Save", systemImage: "square.and.arrow.down") {
                viewModel.footerSaveAction()
            }
        case .active:
            makeButton("Restart", systemImage: "clock.arrow.circlepath") {
                viewModel.footerRestartAction()
            }
        }
    }
    
    private func makeButton(_ label: String, systemImage: String, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            VStack(spacing: 10) {
                Image(systemName: systemImage)
                    .font(.title3)
                ZStack {
                    Text(label)
                        .font(.caption)
                }
            }
        }
    }

    #warning("Need to fix this UI")
    private var pickers: some View {
        VStack(spacing: 0) {
            DatePickerField(date: $viewModel.recipe.timeEnd, displayedComponent: .hourAndMinute, alignment: .bottom)
            DatePickerField(date: $viewModel.recipe.timeEnd, displayedComponent: .date, alignment: .top)
        }
        .foregroundColor(.blue)
        .onChange(of: viewModel.recipe.timeEnd) { timeEnd in
            viewModel.didChange(timeEnd)
        }
    }
}

struct RecipeView_Footer_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .empty())
        RecipeView(.preview, mode: .edit, database: .empty())
        RecipeView(.preview, mode: .active, database: .empty())
    }
}
