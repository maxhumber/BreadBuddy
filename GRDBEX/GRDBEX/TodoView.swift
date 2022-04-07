import SwiftUI
import Combine

struct TodoView: View {
    @StateObject var viewModel: TodoViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        VStack {
            Button {
                viewModel.save()
            } label: {
                Text("Add")
            }
            List($viewModel.todos) { $todo in
                HStack {
                    Button {
                        var todo = todo
                        todo.completed.toggle()
                        viewModel.update(todo)
                    } label: {
                        Image(systemName: todo.completed ? "checkmark.circle" : "circle")
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.blue)
                    TextField("", text: $todo.label)
                        .onSubmit {
                            viewModel.update(todo)
                        }
                    Spacer()
                    Button {
                        viewModel.delete(todo)
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.red)
                }
            }
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
