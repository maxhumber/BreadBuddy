import CustomUI
import SwiftUI

extension RecipeView {
    var footer: some View {
        HStack(alignment: .bottom) {
            leadingButton
                .frame(maxWidth: .infinity)
            pickers
            trailingButton
                .frame(maxWidth: .infinity)
        }
        .foregroundColor(.accent1)
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

    private var pickers: some View {
        VStack(spacing: 0) {
            dayPicker
            timePicker
            Text("Finish")
                .font(.matter(.caption2))
        }
        .opacity(viewModel.mode == .display ? 1 : 0)
        .onChange(of: viewModel.recipe.timeEnd) { timeEnd in
            viewModel.didChange(timeEnd)
        }
    }
    
    private var dayPicker: some View {
        StealthDatePicker(.date, date: $viewModel.recipe.timeEnd, alignment: .bottom) {
            Text(viewModel.recipe.timeEnd.simple)
                .font(.matter(.caption))
                .padding(.bottom, 6)
        }
    }
    
    private var timePicker: some View {
        StealthDatePicker(.hourAndMinute, date: $viewModel.recipe.timeEnd) {
            Text(viewModel.recipe.timeEnd.clocktime)
                .font(.matter(.title, emphasis: .bold))
                .foregroundColor(.text1)
                .padding(.bottom, 6)
        }
    }

    private var deleteAlert: Alert {
        Alert(
            title: Text("Delete"),
            message: Text("Are you sure you want to delete this recipe?"),
            primaryButton: .destructive(Text("Confirm")) {
                viewModel.alertDeleteAction()
                dismiss()
            },
            secondaryButton: .cancel()
        )
    }
    
    private func makeButton(_ label: String, systemImage: String, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            VStack(spacing: 15) {
                Image(systemName: systemImage)
                    .font(.body)
                Text(label)
                    .font(.matter(.caption2))
            }
        }
    }
}

struct RecipeView_Footer_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.preview, mode: .active, database: .preview)
    }
}
