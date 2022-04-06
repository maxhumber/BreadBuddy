import SwiftUI

extension StepRow {
    enum Field {
        case description
        case timeValue
    }
}

public struct StepRow: View {
    @Environment(\.editMode) private var editMode
    @FocusState private var field: Field?
    
    @Binding var step: Step
    var onChange: (() -> ())? = nil
    
    private var unwrappedDate: Date {
        step.date ?? Date()
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 0) {
            description
            timeInput
            timeStack
            if isEditing {
                ellipsis
            }
        }
        .onChange(of: field) { field in
            if field == .none {
                print("focus field:", field)
                onChange?()
            }
        }
    }
    
    private var description: some View {
        TextField("Description", text: $step.description)
            .focused($field, equals: .description)
            .submitLabel(.next)
            .onSubmit {
                print("didSubmit description")
                onChange?()
                field = .timeValue
            }
            .disabled(!isEditing)
            .editBorder()
    }
    
    private var timeInput: some View {
        VStack(spacing: 0) {
            timeValueField
            timeUnitMenu
        }
    }
    
    private var timeValueField: some View {
        ZStack {
            Text("999").opacity(0)
            TextField("", value: $step.timeValue, formatter: .number)
                .focused($field, equals: .timeValue)
                .submitLabel(.done)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: true, vertical: true)
                .keyboardType(.numberPad)
                .if(step.timeValue == 0) {
                    $0.foregroundColor(.gray.opacity(0.5))
                }
                .onSubmit {
                    print("didSubmit timeField")
                    onChange?()
                    field = .none
                }
        }
        .disabled(!isEditing)
        .editBorder()
    }
    
    private var timeUnitMenu: some View {
        Menu {
            ForEach(TimeUnit.allCases) { unit in
                Button {
                    step.timeUnit = unit
                } label: {
                    Text(unit.rawValue)
                }
            }
        } label: {
            ZStack {
                Text("XXXXXXX").opacity(0)
                Text(step.timeUnit.label(for: step.timeValue))
                    .animation(nil, value: UUID())
            }
            .font(.caption2)
        }
        .foregroundColor(isEditing ? .blue : .black)
        .contentShape(Rectangle())
        .disabled(!isEditing)
        .onChange(of: step.timeUnit) { _ in
            onChange?()
        }
    }
    
    private var timeStack: some View {
        VStack(alignment: .trailing, spacing: 0) {
            ZStack(alignment: .trailing) {
                Text("XX:XX XX").opacity(0)
                Text(unwrappedDate.time())
            }
            .padding(.vertical, 5)
            Text(unwrappedDate.weekday())
                .font(.caption2)
        }
        .if(step.date == nil) {
            $0.opacity(0)
        }
    }
    
    private var ellipsis: some View {
        Menu {
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
        } label: {
            ZStack {
                Image(systemName: "circle").opacity(0)
                Image(systemName: "ellipsis")
            }
        }
        .padding(5)
        .padding(.horizontal, 5)
        .contentShape(Rectangle())
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var step = Step(description:  "Mix Ingredients", timeValue: 30, timeUnit: .minutes, date: Date().withAdded(hours: 3))
        
        var body: some View {
            VStack(spacing: 20) {
                StepRow(step: $step)
                    .environment(\.editMode, .constant(.active))
                StepRow(step: $step)
                    .environment(\.editMode, .constant(.inactive))
            }
        }
    }
}
