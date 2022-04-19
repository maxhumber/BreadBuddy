import SwiftUI

extension RecipeView {
    var footer: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ZStack {
                Color.clear.fixedSize(horizontal: false, vertical: true)
                leadingButton
            }
            pickers
            ZStack {
                Color.clear.fixedSize(horizontal: false, vertical: true)
                trailingButton
            }
        }
        .foregroundColor(.primary)
    }
    
    @ViewBuilder private var leadingButton: some View {
        switch viewModel.mode {
        case .display:
            makeButton("Start", systemImage: "clock") {
                viewModel.footerStartAction()
            }
        case .edit:
            makeButton("Delete", systemImage: "trash") {
                viewModel.footerDeleteButtonAction()
            }
            .alert(isPresented: $viewModel.deleteAlertIsPresented) {
                deleteAlert
            }
        case .active:
            makeButton("Restart", systemImage: "clock.arrow.circlepath") {
                viewModel.footerRestartAction()
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
            makeButton("Cancel", systemImage: "xmark.circle") {
                viewModel.footerCancelAction()
            }
        }
    }
    
    private func makeButton(_ label: String, systemImage: String, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            VStack(spacing: 15) {
                Image(systemName: systemImage)
                    .font(.body)
                Text(label)
                    .font(.caption)
            }
        }
    }

    private var pickers: some View {
        VStack(spacing: 0) {
            DatePickerField(date: $viewModel.recipe.timeEnd, displayedComponent: .date, alignment: .bottom)
                .font(.caption)
            DatePickerField(date: $viewModel.recipe.timeEnd, displayedComponent: .hourAndMinute, alignment: .center)
                .font(.title3.bold())
                .padding(.bottom, 5)
            Text("Finish")
                .font(.caption)
        }
        .opacity(viewModel.mode == .display ? 1 : 0)
        .onChange(of: viewModel.recipe.timeEnd) { timeEnd in
            viewModel.didChange(timeEnd)
        }
    }

    private var deleteAlert: Alert {
        Alert(
            title: Text("Delete Recipe"),
            message: Text("Are you sure you want to delete this recipe?"),
            primaryButton: .destructive(Text("Confirm")) {
                viewModel.alertDeleteAction()
                dismiss()
            },
            secondaryButton: .cancel()
        )
    }
}

struct RecipeView_Footer_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.preview, mode: .active, database: .preview)
    }
}
