import Combine
import Foundation
import SwiftUI

final class IndexViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var addViewIsPresented = false
    
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
    
    func addButtonAction() {
        addViewIsPresented = true
    }
}
