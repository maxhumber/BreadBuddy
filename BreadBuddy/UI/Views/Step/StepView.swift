import SwiftUI

struct StepView: View {
    @Environment(\.editMode) private var editMode
    @FocusState private var field: Field?
    
    @Binding var step: Step
    var recipe: Recipe

    init(for step: Binding<Step>, in recipe: Recipe) {
        self._step = step
        self.recipe = recipe
    }
    
    public var body: some View {
        content
            .onChange(of: field) { field in
                if field == .none {
                    #warning("save")
                }
            }
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
            .disabled(isInactive)
            .dynamicBorder()
    }
    
    private var descriptionField: some View {
        TextField("Description", text: $step.description)
            .focused($field, equals: .description)
            .submitLabel(.next)
            .onSubmit {
                field = .timeInMinutes
            }
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
            timeInMinutesField
        }
        .disabled(isInactive)
        .dynamicBorder()
    }
    
    private var timeInMinutesField: some View {
        TextField("", value: $step.timeInMinutes, formatter: .number)
            .opacity(timeInputFieldOpacity)
            .fixedSize(horizontal: true, vertical: true)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .submitLabel(.done)
            .focused($field, equals: .timeInMinutes)
            .onSubmit {
                field = .none
            }
    }
    
    private var timeInputFieldOpacity: Double {
        step.timeInMinutes == 0 ? 0.5 : 1
    }
    
    private var timeUnitPreferenceMenu: some View {
        Menu {
            timeUnitPreferenceMenuOptions
        } label: {
            ZStack {
                SkeleText("XXXXXXX")
                Text(timeUnitLabel)
                    .animation(nil, value: UUID())
            }
            .contentShape(Rectangle())
            .font(.caption2)
            .foregroundColor(timeUnitPreferenceMenuLabelColor)
        }
        .disabled(isInactive)
        .onChange(of: step.timeUnitPreferrence) { _ in
            print("")
        }
    }
    
    private var timeUnitPreferenceMenuLabelColor: Color {
        isEditing ? .blue : .black
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
    
    private var timeUnitLabel: String {
        let unitString = step.timeUnitPreferrence.rawValue.capitalized
        if step.timeInMinutes == 1 {
            return String(unitString.dropLast())
        } else {
            return unitString
        }
    }
    
    private var startTime: some View {
        VStack(alignment: .trailing, spacing: 0) {
            ZStack(alignment: .trailing) {
                SkeleText("XX:XX XX")
                Text(timeString)
            }
            .padding(.vertical, 5)
            Text(weekdayString)
                .font(.caption2)
        }
        .opacity(startTimeOpacity)
    }
    
    private var timeStart: Date {
        step.timeStart ?? Date()
    }
    
    private var timeString: String {
        timeStart.time()
    }
    
    private var weekdayString: String {
        timeStart.weekday()
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
    
    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
    private var isInactive: Bool {
        !isEditing
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var recipe: Recipe = .preview
        @State var step: Step = .preview
        
        var body: some View {
            VStack(spacing: 20) {
                StepView(for: $step, in: recipe)
                    .environment(\.editMode, .constant(.active))
                StepView(for: $step, in: recipe)
                    .environment(\.editMode, .constant(.inactive))
                Spacer()
            }
            .environmentObject(RecipeViewModel(recipe: .preview))
        }
    }
}
