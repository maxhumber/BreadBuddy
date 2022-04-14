import Combine
import Foundation
import SwiftUI

final class IndexViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var editMode: EditMode = .inactive
    @Published var addViewIsPresented = false
    @Published var deleteAlertIsPresented = false
    
    private var database: Database
    private var cancellables = Set<AnyCancellable>()
    
    init(database: Database = .shared) {
        self.database = database
        self.database.publisher()
            .sink { completion in
                print(completion)
            } receiveValue: { recipes in
                self.recipes = recipes
            }
            .store(in: &cancellables)
    }
    
    func onDismissFullScreenCover() {
        editMode = .inactive
    }
    
    func addButtonAction() {
        addViewIsPresented = true
        editMode = .active
    }
    
    func deleteButtonAction() {
        deleteAlertIsPresented = true
    }
    
    func delete(_ recipe: Recipe) {
        Task {
            try? await database.delete(recipe)
        }
    }
}
