import SwiftUI

struct StepView: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    @Environment(\.editMode) private var editMode
    @FocusState private var field: StepField?
    @Binding var step: Step
    
    init(for step: Binding<Step>) {
        self._step = step
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
    public var body: some View {
        content
            .onChange(of: field, perform: viewModel.didChange(field:))
    }
    
    private var content: some View {
        HStack(alignment: .top, spacing: 0) {
            description
            time
            startTime
            if isEditing {
                actionMenu
            }
        }
    }
    
    private var description: some View {
        descriptionField
            .disabled(!isEditing)
            .dynamicBorder()
    }
    
    private var descriptionField: some View {
        TextField("Description", text: $step.description)
            .focused($field, equals: .description)
            .submitLabel(.next)
            .onSubmit { viewModel.didSubmit(&field) }
    }
    
    private var time: some View {
        VStack(spacing: 0) {
            timeInMinutesStack
            timeUnitPreferenceMenu
        }
    }
    
    private var timeInMinutesStack: some View {
        ZStack {
            SkeleText("XXX")
            timeValueField
        }
        .disabled(!isEditing)
        .dynamicBorder()
    }
    
    private var timeValueField: some View {
        TextField("", value: $step.timeValue, formatter: .number)
            .opacity(timeInputFieldOpacity)
            .fixedSize(horizontal: true, vertical: true)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .submitLabel(.done)
            .focused($field, equals: .timeInMinutes)
            .onSubmit { viewModel.didSubmit(&field) }
    }
    
    private var timeInputFieldOpacity: Double {
        step.timeValue == 0 ? 0.5 : 1
    }
    
    private var timeUnitPreferenceMenu: some View {
        Menu {
            timeUnitPreferenceMenuOptions
        } label: {
            timeUnitPreferenceMenuLabel
        }
        .disabled(!isEditing)
        .onChange(of: step.timeUnitPreferrence, perform: viewModel.didChange(timeUnit:))
    }

    @ViewBuilder private var timeUnitPreferenceMenuOptions: some View {
        ForEach(TimeUnit.allCases) { unit in
            Button {
                step.timeUnitPreferrence = unit
            } label: {
                Text(unit.rawValue)
            }
        }
    }
    
    private var timeUnitPreferenceMenuLabel: some View {
        ZStack {
            SkeleText("XXXXXXX")
            Text(timeUnitLabel)
                .animation(nil, value: UUID())
        }
        .contentShape(Rectangle())
        .font(.caption2)
        .foregroundColor(timeUnitPreferenceMenuLabelColor)
    }
    
    private var timeUnitPreferenceMenuLabelColor: Color {
        isEditing ? .blue : .black
    }
    
    private var timeUnitLabel: String {
        let unitString = step.timeUnitPreferrence.rawValue.capitalized
        if step.timeValue == 1 {
            return String(unitString.dropLast())
        } else {
            return unitString
        }
    }
    
    private var startTime: some View {
        VStack(alignment: .trailing, spacing: 0) {
            ZStack(alignment: .trailing) {
                SkeleText("XX:XX XX")
                Text(timeStart.time())
            }
            .padding(.vertical, 5)
            Text(timeStart.weekday())
                .font(.caption2)
        }
        .opacity(startTimeOpacity)
    }
    
    private var timeStart: Date {
        step.timeStart ?? Date()
    }
    
    private var startTimeOpacity: Double {
        step.timeStart == nil ? 0 : 1
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
                StepView(for: $step)
                    .environment(\.editMode, .constant(.active))
                StepView(for: $step)
                    .environment(\.editMode, .constant(.inactive))
                Spacer()
            }
            .environmentObject(viewModel)
        }
    }
}
