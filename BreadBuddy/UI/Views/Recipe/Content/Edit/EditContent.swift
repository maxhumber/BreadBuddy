import SwiftUI

struct EditContent: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                ForEach($viewModel.recipe.steps) { $step in
                    EditRow(for: $step)
                }
                EditRow(for: $viewModel.newStep, mode: .new)
                // can do better here
                EditRow(for: $viewModel.newStep, mode: .new)
                    .opacity(0)
            }
        }
    }
}

struct EditRow: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    @FocusState private var field: StepField?
    @Binding var step: Step
    var mode: StepMode

    init(for step: Binding<Step>, mode: StepMode = .existing) {
        self._step = step
        self.mode = mode
    }
    
    var startTimeString: String {
        let day = step.timeStart?.weekday()
        let time = step.timeStart?.time().lowercased()
        if let day = day, let time = time {
            return "\(day) • \(time)"
        }
        return ""
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            actionMenu
            HStack(alignment: .bottom, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    startTime
                    activity
                }
                duration
                timeUnitMenu
            }
        }
        .padding(.trailing)
        .onChange(of: field) { field in
            viewModel.didChange(to: field, with: mode)
        }
    }
    
    private var actionMenu: some View {
        Menu {
            actionMenuButtons
        } label: {
            actionMenuLabel
        }
        .opacity(mode == .new ? 0 : 1)
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
        Image(systemName: "ellipsis")
            .rotationEffect(.degrees(90))
            .aligned()
            .font(.title3)
            .foregroundColor(.gray)
            .padding(.horizontal, 10)
    }
    
    private var startTime: some View {
        Text(startTimeString)
            .foregroundColor(.gray)
            .font(.caption2.italic())
    }
    
    private var activity: some View {
        TextField("Description", text: $step.description)
            .font(.title3)
            .underscore(infinity: true)
            .focused($field, equals: .description)
            .submitLabel(.next)
            .onSubmit({ field = .timeInMinutes })
    }
    
    private var duration: some View {
        ZStack {
            SkeleText("XXX")
            TextField("", value: $step.timeValue, formatter: .number)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .opacity(step.timeValue == 0 ? 0.5 : 1)
                .focused($field, equals: .timeInMinutes)
                .onSubmit({ field = .none })
        }
        .underscore()
        .font(.title3)
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
            SkeleText("XXXX")
            Text(step.timeUnitString)
                .animation(nil, value: UUID())
        }
        .foregroundColor(.black)
        .font(.title3)
        .underscore()
        .fixedSize()
    }
}

struct EditContent_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .edit, database: .empty())
    }
}
