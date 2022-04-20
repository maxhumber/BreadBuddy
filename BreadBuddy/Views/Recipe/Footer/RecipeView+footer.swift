import CustomUI
import SwiftUI

extension RecipeView {
    var footer: some View {
        VStack(spacing: 10) {
            footerTopRow
            footerBottomRow
        }
        .padding()
        .foregroundColor(.accent1)
    }
    
    @ViewBuilder private var footerTopRow: some View {
        if viewModel.mode == .display {
            pickers
                .onChange(of: viewModel.recipe.timeEnd) { timeEnd in
                    viewModel.didChange(timeEnd)
                }
        }
    }
    
    private var pickers: some View {
        HStack(alignment: .bottom, spacing: 10) {
            timePicker
            dayPicker
        }
        .font(.matter(.caption))
    }
    
    private var timePicker: some View {
        StealthDatePicker(.hourAndMinute, date: $viewModel.recipe.timeEnd) {
            Text(viewModel.recipe.timeEnd.clocktime)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder()
        )
    }
    
    private var dayPicker: some View {
        StealthDatePicker(.date, date: $viewModel.recipe.timeEnd) {
            Text(viewModel.recipe.timeEnd.simple)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder()
        )
    }
    
    private var footerBottomRow: some View {
        HStack(alignment: .bottom, spacing: 10) {
            bottomRowLeadingButton
            bottomRowTrailingButton
        }
    }
    
    private var bottomRowLeadingButton: some View {
        Group {
            switch viewModel.mode {
            case .display: startButton
            case .edit: deleteButton
            case .active: restartButton
            }
        }
        .buttonStyle(StrokedButtonStyle())
    }
    
    private var bottomRowTrailingButton: some View {
        Group {
            switch viewModel.mode {
            case .display: editButton
            case .edit: saveButton
            case .active: cancelButton
            }
        }
        .buttonStyle(StrokedButtonStyle())
    }
    
    private var startButton: some View {
        Button {
            viewModel.footerStartAction()
        } label: {
            makeButtonLabel("Start", systemImage: "clock")
        }
    }
    
    private var deleteButton: some View {
        Button {
            viewModel.footerDeleteButtonAction()
        } label: {
            makeButtonLabel("Delete", systemImage: "trash")
        }
        .alert(isPresented: $viewModel.deleteAlertIsPresented) {
            deleteAlert
        }
    }
    
    private var restartButton: some View {
        Button {
            viewModel.footerRestartAction()
        } label: {
            makeButtonLabel("Restart", systemImage: "clock.arrow.circlepath")
        }
    }
    
    private var editButton: some View {
        Button {
            viewModel.footerEditAction()
        } label: {
            makeButtonLabel("Edit", systemImage: "pencil")
        }
    }
    
    private var saveButton: some View {
        Button {
            viewModel.footerSaveAction()
        } label: {
            makeButtonLabel("Save", systemImage: "square.and.arrow.down")
        }
    }
    
    private var cancelButton: some View {
        Button {
            viewModel.footerCancelAction()
        } label: {
            makeButtonLabel("Cancel", systemImage: "xmark.circle")
        }
    }
    
    private func makeButtonLabel(_ label: String, systemImage: String) -> some View {
        HStack {
            ZStack {
                Image(systemName: "trash").opacity(0)
                Image(systemName: systemImage)
            }
            .font(.body)
            Text(label)
                .font(.matter(.caption2))
        }
        .padding()
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
}

struct RecipeView_Footer_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.preview, mode: .active, database: .preview)
    }
}
