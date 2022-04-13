import SwiftUI

struct InnerStepRow: View {
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
            .if(mode == .new) {
                $0.onChange(of: field, perform: viewModel.didChange(field:))
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
            .if(mode == .new) {
                $0.onSubmit { viewModel.didSubmit(&field) }
            } else: {
                $0.onSubmit { viewModel.didSubmit(&field) }
            }
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
            .keyboardType(.numberPad)
            .submitLabel(.done)
            .focused($field, equals: .timeInMinutes)
            .if(mode == .new) {
                $0.onSubmit { viewModel.didSubmit(&field) }
            } else: {
                $0.onSubmit { viewModel.didSubmit(&field) }
            }
    }
    
    private var timeUnitMenu: some View {
        Menu {
            timeUnitMenuOptions
        } label: {
            timeUnitMenuLabel
        }
        .disabled(!isEditing)
        .onChange(of: step.timeUnit, perform: viewModel.didChange(timeUnit:))
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
            print("up")
        } label: {
            Label("Add step above", systemImage: "arrow.up")
        }
        Button {
            print("down")
        } label: {
            Label("Add step below", systemImage: "arrow.down")
        }
        Button(role: .destructive) {
            print("delete")
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
                InnerStepRow(for: $step)
                    .environment(\.editMode, .constant(.inactive))
                InnerStepRow(for: $step)
                    .environment(\.editMode, .constant(.active))
//                NewStepRow()
//                    .environment(\.editMode, .constant(.active))
                Spacer()
            }
            .environmentObject(viewModel)
        }
    }
}
