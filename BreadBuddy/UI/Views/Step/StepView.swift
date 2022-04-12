import SwiftUI

public struct StepView: View {
    @EnvironmentObject private var stepsViewModel: RecipeViewModel
    @Environment(\.editMode) private var editMode
    @FocusState private var field: Field?
    @StateObject var viewModel: ViewModel

    init(for step: Step, in recipe: Recipe) {
        _viewModel = StateObject(wrappedValue: .init(for: step, in: recipe))
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
    private var isInactive: Bool {
        !isEditing
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
        TextField("Description", text: $viewModel.step.description)
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
            placeholder("XXX")
            timeInMinutesField
        }
        .disabled(isInactive)
        .dynamicBorder()
    }
    
    private var timeInMinutesField: some View {
        TextField("", value: $viewModel.step.timeInMinutes, formatter: .number)
            .opacity(viewModel.timeInputFieldOpacity)
            .fixedSize(horizontal: true, vertical: true)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .submitLabel(.done)
            .focused($field, equals: .timeInMinutes)
            .onSubmit {
                field = .none
            }
    }
    
    private var timeUnitPreferenceMenu: some View {
        Menu {
            ForEach(TimeUnit.allCases) { unit in
                Button {
                    viewModel.step.timeUnitPreferrence = unit
                } label: {
                    Text(unit.rawValue)
                }
            }
        } label: {
            ZStack {
                placeholder("XXXXXXX")
                Text(viewModel.timeUnitLabel)
                    .animation(nil, value: UUID())
            }
            .font(.caption2)
        }
        .foregroundColor(isEditing ? .blue : .black)
        .contentShape(Rectangle())
        .disabled(isInactive)
        .onChange(of: viewModel.step.timeUnitPreferrence) { _ in
            print("")
        }
    }
    
    private var startTime: some View {
        VStack(alignment: .trailing, spacing: 0) {
            ZStack(alignment: .trailing) {
                placeholder("XX:XX XX")
                Text(viewModel.timeString)
            }
            .padding(.vertical, 5)
            Text(viewModel.weekdayString)
                .font(.caption2)
        }
        .opacity(viewModel.startTimeOpacity)
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
    
    private func placeholder(_ string: String) -> some View {
        Text(string).opacity(0)
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var recipe: Recipe = .preview
        @State var step: Step = .preview
        
        var body: some View {
            VStack(spacing: 20) {
                StepView(for: step, in: recipe)
                    .environment(\.editMode, .constant(.active))
                StepView(for: step, in: recipe)
                    .environment(\.editMode, .constant(.inactive))
                Spacer()
            }
            .environmentObject(RecipeViewModel(recipe: .preview))
        }
    }
}
