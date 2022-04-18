import BBKit
import SwiftUI

struct Edit: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    @FocusState private var field: StepEditField?
    @Binding var step: Step
    var mode: StepEditMode

    init(_ step: Binding<Step>, mode: StepEditMode = .existing) {
        self._step = step
        self.mode = mode
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            actionButton
            HStack(alignment: .bottom, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    startTime
                    activity
                }
                duration
                timeUnitMenu
            }
        }
        .onChange(of: field) { field in
            viewModel.didChange(to: field, with: mode)
        }
    }
    
    private var actionButton: some View {
        Menu {
            actionMenuOptions
        } label: {
            actionMenuLabel
        }
        .opacity(mode == .new ? 0 : 1)
    }
    
    @ViewBuilder private var actionMenuOptions: some View {
        Button {
            viewModel.insert(step)
        } label: {
            Label("Add step above", systemImage: "arrow.up")
        }
        Button {
            viewModel.insert(step, after: true)
        } label: {
            Label("Add step below", systemImage: "arrow.down")
        }
        Button(role: .destructive) {
            viewModel.delete(step)
        } label: {
            Label("Delete", systemImage: "xmark")
        }
    }
    
    private var actionMenuLabel: some View {
        Image(systemName: "ellipsis")
            .rotationEffect(.degrees(90))
            .foregroundColor(.secondary)
            .aligned()
            .padding(.trailing, 10)
            .padding(.leading, -5)
    }
    
    private var startTime: some View {
        Text(step.startTimeString)
            .foregroundColor(.secondary)
            .font(.caption2.italic())
    }
    
    private var activity: some View {
        TextField("Description", text: $step.description)
            .underscore(infinity: true)
            .focused($field, equals: .description)
            .submitLabel(.next)
            .onSubmit {
                field = .timeInMinutes
            }
    }
    
    private var duration: some View {
        ZStack {
            Text.scaffold("XXX")
            TextField("", value: $step.timeValue, formatter: .number)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .opacity(step.timeValue == 0 ? 0.5 : 1)
                .focused($field, equals: .timeInMinutes)
                .onSubmit {
                    field = .none
                }
        }
        .underscore()
    }
    
    private var timeUnitMenu: some View {
        Menu {
            timeUnitMenuOptions
        } label: {
            timeUnitMenuLabel
        }
        .onChange(of: step.timeUnit) { timeUnit in
            viewModel.didChange(timeUnit, with: mode)
        }
    }
    
    @ViewBuilder private var timeUnitMenuOptions: some View {
        ForEach(TimeUnit.allCases) { unit in
            Button {
                step.timeUnit = unit
            } label: {
                Text(unit.label)
            }
        }
    }
    
    private var timeUnitMenuLabel: some View {
        ZStack(alignment: .center) {
            Text.scaffold("XXXX")
            Text(step.timeUnitString)
                .animation(nil, value: UUID())
        }
        .foregroundColor(.primary)
        .underscore()
    }
}

struct EditContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .edit, database: .preview)
    }
}
