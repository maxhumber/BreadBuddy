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
            content
                .onChange(of: field) { field in
                    viewModel.didChange(to: field, with: mode)
                }
        }
        
        private var content: some View {
            HStack(alignment: .center, spacing: 5) {
                actionButton
                HStack(alignment: .bottom, spacing: 5) {
                    activity
                    duration
                    timeUnitMenu
                }
            }
            .font(.bodyMatter)
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
                .padding(.trailing, 5)
                .padding(.leading, -5)
                .foregroundColor(.accent1)
        }
        
        private var activity: some View {
            TextField("Description", text: $step.description)
                .foregroundColor(.text1)
                .underscore(infinity: true)
                .foregroundColor(.accent2)
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
                    .foregroundColor(.text1)
                    .opacity(step.timeValue == 0 ? 0.25 : 1)
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .focused($field, equals: .timeValue)
                    .onSubmit {
                        field = .none
                    }
            }
            .underscore()
            .foregroundColor(.accent2)
        }
        
        private var timeUnitMenu: some View {
            Menu {
                timeUnitMenuOptions
            } label: {
                timeUnitMenuLabel
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
                TextScaffold("XXXX")
                Text(step.unitLabel)
                    .animation(nil, value: UUID())
                    .foregroundColor(.text1)
            }
            .underscore()
            .foregroundColor(.accent2)
        }
    }
}

struct EditContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .edit, database: .preview)
    }
}
