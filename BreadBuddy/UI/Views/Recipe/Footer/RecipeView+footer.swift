import CustomUI
import SwiftUI

extension RecipeView {
    var footer: some View {
        Group {
            switch viewModel.mode {
            case .plan: planFooter
            case .edit: editFooter
            case .make: Text("Hey")
            }
        }
        .foregroundColor(.accent1)
        .font(.matter(.caption))
        .padding()
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
        .padding(.leading, -2)
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
        }
        .buttonStyle(FancyButtonStyle(outline: .accent1, fill: .accent2))
    }
    
    private var resetButton: some View {
        AlertingButton {
            resetAlert
        } label: {
            makeButtonLabel("Reset", systemImage: "clock.arrow.circlepath")
        }
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
                viewModel.stop()
            },
            secondaryButton: .cancel()
        )
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
}

struct RecipeView_Footer_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .edit, database: .preview)
        RecipeView(.init(), mode: .edit, database: .preview)
        RecipeView(.preview, mode: .plan, database: .preview)
        RecipeView(.preview, mode: .make, database: .preview)
    }
}
