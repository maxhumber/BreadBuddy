import Foundation
import Combine

@MainActor final class TodoListViewModel: ObservableObject {
    private let database: Database
    private var cancellables = Set<AnyCancellable>()
    
    @Published var todos = [Todo]()
    
    init(_ database: Database = .shared) {
        self.database = database
        database.todoPublisher()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { todos in
                self.todos = todos
            }
            .store(in: &cancellables)
    }
    
    func save() {
        Task {
            let string = String(UUID().uuidString.prefix(6))
            let priority = Priority.allCases.randomElement()!
            var todo = Todo(label: string, priority: priority, dateCreated: Date(), dateModified: Date())
            try await database.save(&todo)
        }
    }
    
    func update(_ todo: Todo) {
        Task {
            var todo = todo
            todo.dateModified = Date()
            try? await database.update(todo)
        }
    }
    
    func delete(_ todo: Todo) {
        Task {
            try? await database.delete(todo)
        }
    }
}
