import SwiftUI

public struct Row: View {
    @Environment(\.editMode) private var editMode
    @Binding var label: String
    @Binding var value: Double
    @Binding var unit: TimeUnit
    @Binding var date: Date?
    var onChange: (() -> ())? = nil
    
    private var unwrappedDate: Date {
        date ?? Date()
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
//        .if(unwrappedDate < Date()) {
//            $0.opacity(0.5)
//        }
    }
    
    private var description: some View {
        TextField("Description", text: $label) {
            onChange?()
        }
        .disabled(!isEditing)
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder()
                .foregroundColor(.gray.opacity(0.25))
                .if(!isEditing) {
                    $0.opacity(0)
                }
        )
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
            NumberField(value: $value)
        }
        .disabled(!isEditing)
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder()
                .foregroundColor(.gray.opacity(0.25))
                .if(!isEditing) {
                    $0.opacity(0)
                }
        )
    }
    
    private var timeUnitMenu: some View {
        Menu {
            ForEach(TimeUnit.allCases) { unit in
                Button {
                    self.unit = unit
                } label: {
                    Text(unit.rawValue)
                }
            }
        } label: {
            ZStack {
                Text("XXXXXXX").opacity(0)
                Text(unit.label(for: value))
                    .animation(nil, value: UUID())
            }
            .font(.caption2)
        }
        .contentShape(Rectangle())
        .disabled(!isEditing)
        .onChange(of: unit) { _ in
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
        .if(date == nil) {
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
        @State var label = "Mix Ingredients"
        @State var value = 0.5
        @State var unit: TimeUnit = .minutes
        @State var date: Date? = Date().withAdded(hours: 3)
        
        var body: some View {
            VStack(spacing: 20) {
                Row(label: $label, value: $value, unit: $unit, date: $date)
                    .environment(\.editMode, .constant(.active))
                Row(label: $label, value: $value, unit: $unit, date: $date)
                    .environment(\.editMode, .constant(.inactive))
            }
        }
    }
}
