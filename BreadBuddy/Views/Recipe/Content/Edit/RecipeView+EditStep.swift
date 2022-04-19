import Core
import CustomUI
import SwiftUI

extension RecipeView {
    struct EditStep: View {
        @EnvironmentObject var viewModel: RecipeViewModel
        @FocusState private var field: EditStepField?
        @Binding var step: Step
        var mode: EditStepMode
        
        init(_ step: Binding<Step>, mode: EditStepMode = .existing) {
            self._step = step
            self.mode = mode
        }
        
        var body: some View {
            HStack(alignment: .center, spacing: 5) {
                actionButton
                HStack(alignment: .bottom, spacing: 5) {
                    activity
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
                Label("Delete", systemImage: "trash")
            }
        }
        
        private var actionMenuLabel: some View {
            Image(systemName: "ellipsis")
                .rotationEffect(.degrees(90))
                .foregroundColor(.secondary)
                .padding(.trailing, 5)
                .padding(.leading, -5)
        }
        
        private var activity: some View {
            TextField("Description", text: $step.description)
                .underscore(infinity: true)
                .focused($field, equals: .description)
                .submitLabel(.next)
                .onSubmit {
                    field = .timeValue
                }
        }
        
        private var duration: some View {
            ZStack {
                TextScaffold("XXX")
                TextField("", value: $step.timeValue, formatter: .number)
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .opacity(step.timeValue == 0 ? 0.25 : 1)
                    .focused($field, equals: .timeValue)
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
//            .onChange(of: step.timeUnit) { timeUnit in
//                viewModel.didChange(timeUnit, with: mode)
//            }
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
                TextScaffold("XXXX")
                Text(step.unitLabel)
                    .animation(nil, value: UUID())
            }
            .underscore()
            .foregroundColor(.primary)
        }
    }
}

struct EditContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .edit, database: .preview)
    }
}
