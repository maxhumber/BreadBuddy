import CustomUI
import SwiftUI

extension RecipeView {
    var footer: some View {
        Group {
            switch viewModel.mode {
            case .plan: planFooter
            case .make: Text("Hey")
            case .edit: editFooter
            }
        }
        .foregroundColor(.accent1)
        .padding()
    }
    
    private var editFooter: some View {
        Button {
            viewModel.footerSaveAction()
        } label: {
            makeButtonLabel(viewModel.footerSaveLabel, systemImage: viewModel.footerSaveSystemImage)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
    }
    
    private var planFooter: some View {
        HStack(spacing: 15) {
            startButton
            finishButton
        }
    }
    
    private var startButton: some View {
        Button {
            viewModel.footerStartAction()
        } label: {
            ZStack {
                Image(systemName: "flag").opacity(0)
                Image(systemName: "play")
            }
            .padding()
        }
        .font(.matter(.caption2))
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
    }
    
    private var finishButton: some View {
        Button {} label: {
            HStack {
                dayPicker
                timePicker
            }
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity)
            .font(.matter(.caption))
        }
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
        .padding(.leading, -2)
        .onChange(of: viewModel.recipe.timeEnd) { timeEnd in
            viewModel.didChange(timeEnd)
        }
    }

    private var dayPicker: some View {
        StealthDatePicker(.date, date: $viewModel.recipe.timeEnd) {
            HStack(spacing: 15) {
                Image(systemName: "calendar")
                Text(viewModel.recipe.timeEnd.simple)
            }
        }
    }
    private var timePicker: some View {
        StealthDatePicker(.hourAndMinute, date: $viewModel.recipe.timeEnd) {
            Text(viewModel.recipe.timeEnd.clocktime)
        }
    }
    
    @ViewBuilder private var editBottomRowLeadingButton: some View {
        if viewModel.cancelEditButtonIsDisplayed {
            editCancel
        } else {
//            deleteButton
        }
    }

    
    private var editCancel: some View {
        Button {
            dismiss()
        } label: {
            makeButtonLabel("Cancel", systemImage: "xmark")
        }
    }
    
    private var resetButton: some View {
        AlertingButton {
            resetAlert
        } label: {
            makeButtonLabel("Reset", systemImage: "clock.arrow.circlepath")
        }
    }
    
    private var editButton: some View {
        Button {
            viewModel.edit()
        } label: {
            makeButtonLabel("Edit", systemImage: "pencil")
        }
    }
    
    private var saveButton: some View {
        Button {
            viewModel.footerSaveAction()
        } label: {
            makeButtonLabel(viewModel.footerSaveLabel, systemImage: viewModel.footerSaveSystemImage)
        }
        .foregroundColor(viewModel.saveButtonIsDisabled ? .accent2 : .accent1)
        .disabled(viewModel.saveButtonIsDisabled)
    }
    
    private var stopButton: some View {
        AlertingButton {
            stopAlert
        } label: {
            makeButtonLabel("Stop", systemImage: "xmark.circle")
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
    
    private var stopAlert: Alert {
        Alert(
            title: Text("Stop"),
            message: Text("Are you sure you want to stop making this recipe?"),
            primaryButton: .destructive(Text("Confirm")) {
                viewModel.footerStopAction()
            },
            secondaryButton: .cancel()
        )
    }
    
    private var resetAlert: Alert {
        Alert(
            title: Text("Reset"),
            message: Text("Are you sure you want to reset the start time for this recipe?"),
            primaryButton: .destructive(Text("Confirm")) {
                viewModel.footerResetAction()
            },
            secondaryButton: .cancel()
        )
    }
}

struct RecipeView_Footer_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .plan, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.init(), mode: .edit, database: .preview)
        RecipeView(.preview, mode: .make, database: .preview)
    }
}
