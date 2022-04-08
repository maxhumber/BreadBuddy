import SwiftUI
import Combine

struct SubTodoListView: View {
    @StateObject var viewModel: SubTodoListViewModel
    
    init(todo: Todo, database: Database = .shared) {
        _viewModel = StateObject(wrappedValue: .init(todo: todo, database: .shared))
    }
    
    var body: some View {
        VStack {
            Button {
                viewModel.save()
            } label: {
                Text("Add")
            }
            List($viewModel.subTodos) { $subTodo in
                HStack {
                    Button {
                        var subTodo = subTodo
                        subTodo.completed.toggle()
                        viewModel.update(subTodo)
                    } label: {
                        Image(systemName: subTodo.completed ? "checkmark.circle" : "circle")
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.blue)
                    HStack {
                        TextField("", text: $subTodo.label)
                            .onSubmit {
                                viewModel.update(subTodo)
                        }
                        Text(subTodo.steps.map({String($0)}).joined(separator: ","))
                    }
                    Spacer()
                    Button {
                        viewModel.delete(subTodo)
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
