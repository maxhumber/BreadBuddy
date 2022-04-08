import Foundation
import Combine

@MainActor final class SubTodoListViewModel: ObservableObject {
    private let database: Database
    private let todo: Todo
    
    @Published var subTodos = [SubTodo]()
    private var cancellables = Set<AnyCancellable>()
    
    init(todo: Todo, database: Database = .shared) {
        self.todo = todo
        self.database = database
        database.subTodoPublisher(for: todo)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { subTodos in
                self.subTodos = subTodos
            }
            .store(in: &cancellables)
    }
    
    func save() {
        Task {
            let string = String(UUID().uuidString.prefix(6))
            var subTodo = SubTodo(todoId: todo.id, label: string, completed: false, dateCreated: Date())
            try await database.save(&subTodo)
        }
    }
    
    func update(_ subTodo: SubTodo) {
        Task {
            var subTodo = subTodo
            subTodo.dateModified = Date()
            try? await database.update(subTodo)
        }
    }
    
    func delete(_ subTodo: SubTodo) {
        Task {
            try? await database.delete(subTodo)
        }
    }
}
