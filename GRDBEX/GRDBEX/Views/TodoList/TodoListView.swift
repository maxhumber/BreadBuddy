import SwiftUI
import Combine

struct TodoListView: View {
    @StateObject var viewModel: TodoListViewModel
    
    init(database: Database = .shared) {
        _viewModel = StateObject(wrappedValue: .init(database))
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationBarHidden(true)
        }
    }
    
    private var content: some View {
        VStack {
            Button {
                viewModel.save()
            } label: {
                Text("Add")
            }
            List($viewModel.todos) { $todo in
                NavigationLink {
                    SubTodoListView(todo: todo, database: .shared)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    HStack {
                        Button {
                            print("hey")
                        } label: {
                            Image(systemName: "arrow.up")
                                .foregroundColor(
                                    color(for: todo.priority)
                                )
                        }
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
    
    private func color(for priority: Todo.Priority?) -> Color {
        guard let priority = priority else { return .black }
        switch priority {
        case .low: return .green
        case .medium: return .orange
        case .high: return .red
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(database: .shared)
    }
}
