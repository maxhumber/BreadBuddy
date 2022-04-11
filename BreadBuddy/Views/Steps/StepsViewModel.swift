//import Combine
//import Foundation
//
//final class ViewModel: ObservableObject {
//    @Published var recipe: String
//    @Published var date: Date
//    @Published var steps: [Step]
//    @Published var step: Step = .init()
//
//    init(recipe: String, date: Date? = nil, steps: [Step] = [Step]()) {
//        self.recipe = recipe
//        let nextSunday = Date().next(.sunday)?.withAdded(hours: 15)
//        self.date = date ?? nextSunday ?? Date()
//        self.steps = steps
//    }
//
//    @MainActor func add() {
//        if step.timeValue != 0 {
//            steps.append(step)
//            step = .init()
//            refresh()
//        }
//    }
//
//    func remove(at offsets: IndexSet) {
//        steps.remove(atOffsets: offsets)
//    }
//
//    @MainActor func refresh() {
//        var currentTime = date
//        for step in steps.reversed() {
//            switch step.timeUnit {
//            case .minutes:
//                currentTime = currentTime.withAdded(minutes: -step.timeValue)
//            case .hours:
//                currentTime = currentTime.withAdded(hours: -step.timeValue)
//            case .days:
//                currentTime = currentTime.withAdded(days: -step.timeValue)
//            }
//            if let index = steps.firstIndex(where: { $0 == step }) {
//                steps[index].date = currentTime
//            }
//        }
//    }
//}
//
//import Foundation
//import Combine
//
//@MainActor final class StepsViewModel: ObservableObject {
//    private let database: Database
//    private var cancellables = Set<AnyCancellable>()
//    @Published var recipe: Recipe
//    @Published var step: Step
//
//    init(recipe: Recipe, database: Database = .shared) {
//        self.recipe = recipe
//        self.database = database
//        self.step = .init()
//    }
//
//    func save() {
//        Task {
//            var updatedRecipe = self.recipe
//            //            if step.timeInMinutes != 0 {
//            updatedRecipe.steps.append(step)
//            self.step = .init()
//            //            }
//            self.recipe = updatedRecipe
//            try await database.save(&updatedRecipe)
//        }
//    }
//
//    func update() {
//        Task {
//            var updatedRecipe = self.recipe
//            updatedRecipe.dateModified = Date()
//            self.recipe = updatedRecipe
//            try await database.save(&updatedRecipe)
//        }
//    }
//}
//
//
