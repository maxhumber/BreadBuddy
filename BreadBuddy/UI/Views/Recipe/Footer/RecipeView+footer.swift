import CustomUI
import SwiftUI

extension RecipeView {
    var footer: some View {
        Group {
            switch viewModel.mode {
            case .plan: planFooter
            case .edit: editFooter
            case .make: makeFooter
            }
        }
        .foregroundColor(.accent1)
        .font(.matter(.caption))
        .padding()
        .padding(.horizontal)
        .padding(.leading, -2)
    }
    
    private var planFooter: some View {
        HStack(spacing: 15) {
            startButton
            finishButton
        }
    }
    
    private var startButton: some View {
        Button {
            viewModel.start()
        } label: {
            ZStack {
                Image(systemName: "xmark")
                    .padding()
                    .opacity(0)
                Image(systemName: "play")
            }
        }
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
    }
    
    private var finishButton: some View {
        Button {} label: {
            HStack {
                dayPicker
                timePicker
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
        .onChange(of: viewModel.recipe.timeEnd) { timeEnd in
            viewModel.didChange(timeEnd)
        }
    }
    
    private var dayPicker: some View {
        StealthDatePicker(.date, date: $viewModel.recipe.timeEnd) {
            HStack(spacing: 0) {
                ZStack {
                    Image(systemName: "xmark")
                        .padding()
                        .opacity(0)
                    Image(systemName: "calendar")
                }
                Text(viewModel.recipe.timeEnd.simple)
            }
        }
    }
    private var timePicker: some View {
        StealthDatePicker(.hourAndMinute, date: $viewModel.recipe.timeEnd) {
            Text(viewModel.recipe.timeEnd.clocktime)
        }
        .padding(.trailing, 5)
    }
    
    private var editFooter: some View {
        HStack(spacing: 15) {
            if viewModel.discardButtonIsDislayed {
                discardButton
            }
            doneButton
        }
    }
    
    private var discardButton: some View {
        Button {
            viewModel.discard()
        } label: {
            Image(systemName: "xmark")
                .padding()
        }
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
    }
    
    private var doneButton: some View {
        Button {
            viewModel.done()
        } label: {
            HStack {
                ZStack {
                    Image(systemName: "xmark")
                        .padding(.vertical)
                        .opacity(0)
                    Image(systemName: "checkmark")
                }
                Text("Done")
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(viewModel.doneButtonIsDisabled ? .accent2 : .accent1)
        }
        .buttonStyle(
            FancyButtonStyle(
                outline: viewModel.doneButtonIsDisabled ? .accent2 : .accent1,
                fill: viewModel.doneButtonIsDisabled ? .clear : .accent2
            )
        )
        .disabled(viewModel.doneButtonIsDisabled)
    }
    
    private var makeFooter: some View {
        HStack(spacing: 15) {
            resetButton
            stopButton
        }
    }
    
    private var resetButton: some View {
        AlertingButton {
            resetAlert
        } label: {
            ZStack {
                Image(systemName: "xmark")
                    .padding()
                    .opacity(0)
                Image(systemName: "clock.arrow.circlepath")
            }
        }
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
    }
    
    private var resetAlert: Alert {
        Alert(
            title: Text("Reset"),
            message: Text("Are you sure you want to reset the start time for this recipe?"),
            primaryButton: .destructive(Text("Confirm")) {
                viewModel.reset()
            },
            secondaryButton: .cancel()
        )
    }
    
    private var stopButton: some View {
        AlertingButton {
            stopAlert
        } label: {
            HStack(spacing: 10) {
                ZStack {
                    Image(systemName: "xmark")
                        .padding(.vertical)
                        .opacity(0)
                    Image(systemName: "xmark.circle")
                }
                Text("Stop")
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
    }
    
    private var stopAlert: Alert {
        Alert(
            title: Text("Stop"),
            message: Text("Are you sure you want to stop making this recipe?"),
            primaryButton: .destructive(Text("Confirm")) {
                viewModel.stop()
            },
            secondaryButton: .cancel()
        )
    }
}

struct RecipeView_Footer_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .make, database: .preview)
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.init(), mode: .edit, database: .preview)
        RecipeView(.preview, mode: .plan, database: .preview)
    }
}
