import SwiftUI

struct StepNewRow: View {
    @Environment(\.editMode) private var editMode
    @Binding var step: Step
    
    init(for step: Binding<Step>) {
        self._step = step
    }
    
    var body: some View {
        StepRow(for: $step, mode: .new)
            .opacity(editMode?.wrappedValue == .active ? 1 : 0)
    }
}

struct StepRow: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    @Environment(\.editMode) private var editMode
    @FocusState private var field: StepField?
    @Binding var step: Step
    var mode: StepMode
    
    init(for step: Binding<Step>, mode: StepMode = .existing) {
        self._step = step
        self.mode = mode
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
    public var body: some View {
        content
            .onChange(of: field) { field in
                viewModel.didChange(to: field, with: mode)
            }
    }
    
    private var content: some View {
        HStack(alignment: .top, spacing: 0) {
            description
            timeComponents
            timeStart
            if isEditing {
                actionMenu
            }
        }
    }
    
    private var description: some View {
        TextField("Description", text: $step.description)
            .dynamicBorder()
            .disabled(!isEditing)
            .focused($field, equals: .description)
            .submitLabel(.next)
            .onSubmit({ field = .timeInMinutes })
    }
    
    private var timeComponents: some View {
        VStack(spacing: 0) {
            timeStack
            timeUnitMenu
        }
    }
    
    private var timeStack: some View {
        ZStack {
            SkeleText("XXX")
            timeValue
        }
        .disabled(!isEditing)
        .dynamicBorder()
    }
    
    private var timeValue: some View {
        TextField("", value: $step.timeValue, formatter: .number)
            .opacity(step.timeValue == 0 ? 0.5 : 1)
            .fixedSize(horizontal: true, vertical: true)
            .multilineTextAlignment(.center)
            .keyboardType(.decimalPad)
            .submitLabel(.done)
            .focused($field, equals: .timeInMinutes)
            .onSubmit({ field = .none })
    }
    
    private var timeUnitMenu: some View {
        Menu {
            timeUnitMenuOptions
        } label: {
            timeUnitMenuLabel
        }
        .disabled(!isEditing)
        .onChange(of: step.timeUnit) { timeUnit in
            viewModel.didChange(timeUnit, with: mode)
        }
    }

    @ViewBuilder private var timeUnitMenuOptions: some View {
        ForEach(TimeUnit.allCases) { unit in
            Button {
                step.timeUnit = unit
            } label: {
                Text(unit.rawValue)
            }
        }
    }
    
    private var timeUnitMenuLabel: some View {
        ZStack {
            SkeleText("XXXXXXX")
            Text(step.timeUnitString)
                .animation(nil, value: UUID())
        }
        .contentShape(Rectangle())
        .font(.caption2)
        .foregroundColor(isEditing ? .blue : .black)
    }
    
    private var timeStart: some View {
        VStack(alignment: .trailing, spacing: 0) {
            ZStack(alignment: .trailing) {
                SkeleText("XX:XX XX")
                Text(step.timeStartString)
            }
            .padding(.vertical, 5)
            Text(step.timeStartWeekdayString)
                .font(.caption2)
        }
        .opacity(step.timeStart == nil ? 0 : 1)
    }
    
    private var actionMenu: some View {
        Menu {
            actionMenuButtons
        } label: {
            actionMenuLabel
        }
    }
    
    @ViewBuilder private var actionMenuButtons: some View {
        Button {
            viewModel.insertBefore(step)
        } label: {
            Label("Add step above", systemImage: "arrow.up")
        }
        Button {
            viewModel.insertAfter(step)
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
        ZStack {
            Image(systemName: "circle").opacity(0)
            Image(systemName: "ellipsis")
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .contentShape(Rectangle())
        .opacity(mode == .existing ? 1 : 0)
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @StateObject var viewModel: RecipeViewModel
        @State var step: Step = .preview
        
        init(recipe: Recipe = .init(), database: Database = .shared) {
            let viewModel = RecipeViewModel(recipe: recipe, database: database)
            _viewModel = StateObject(wrappedValue: viewModel)
        }
        
        var body: some View {
            VStack(spacing: 20) {
                StepRow(for: $step)
                    .environment(\.editMode, .constant(.inactive))
                StepRow(for: $step)
                    .environment(\.editMode, .constant(.active))
                StepNewRow(for: $step)
                    .environment(\.editMode, .constant(.active))
                Spacer()
            }
            .environmentObject(viewModel)
        }
    }
}
