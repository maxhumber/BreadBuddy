import SwiftUI

public struct Row: View {
    @Environment(\.editMode) private var editMode
    
    @Binding var label: String
    @Binding var value: Double
    @Binding var unit: TimeUnit
    @Binding var date: Date?
    var onChange: (() -> ())? = nil
    
    public var body: some View {
        HStack(alignment: .top, spacing: 0) {
            description
            TimeInput(value: $value, unit: $unit) {
                onChange?()
            }
            timeStack
            Menu {
                Button {
                    
                } label: {
                    Label("Add step above", systemImage: "arrow.up")
                }
                Button {
                    
                } label: {
                    Label("Add step below", systemImage: "arrow.down")
                }
                Button(role: .destructive) {
                    
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
            .contentShape(Rectangle())
        }
        .if(unwrappedDate < Date()) {
            $0.opacity(0.5)
        }
    }
    
    private var description: some View {
        TextField("Description", text: $label) {
            onChange?()
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder()
                .foregroundColor(.gray.opacity(0.25))
        )
    }
    
    private var timeStack: some View {
        VStack(alignment: .trailing, spacing: 0) {
            ZStack(alignment: .trailing) {
                Text("XX:XX XX").opacity(0)
                Text(unwrappedDate.time())
            }
            .padding(5)
            Text(unwrappedDate.weekday())
                .font(.caption2)
                .padding(.trailing, 5)
        }
        .opacity(timeStackOpacity)
    }
    
    private var unwrappedDate: Date {
        date ?? Date()
    }
    
    private var timeStackOpacity: Double {
        date == nil ? 0 : 1
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        @State var label = "Mix Ingredients"
        @State var value = 0.5
        @State var unit: TimeUnit = .minute
        @State var date: Date? = Date()
        
        var body: some View {
            VStack(spacing: 20) {
                Row(label: $label, value: $value, unit: $unit, date: $date)
                    .environment(\.editMode, .constant(.active))
            }
        }
    }
}
