import Combine
import Foundation

extension TimeView {
    final class ViewModel: ObservableObject {
        @Published var recipe: String
        @Published var date: Date
        @Published var steps: [Step]
        
        init(recipe: String, date: Date? = nil, steps: [Step] = [Step]()) {
            self.recipe = recipe
            let nextSunday = Date().next(.sunday)?.withAdded(hours: 15)
            self.date = date ?? nextSunday ?? Date()
            self.steps = steps
        }
        
        @MainActor func add() {
            let step = Step(description: "", timeValue: 30, timeUnit: .minute)
            steps.append(step)
            refresh()
        }
        
        func remove(at offsets: IndexSet) {
            steps.remove(atOffsets: offsets)
        }
        
        @MainActor func refresh() {
            var currentTime = date
            for step in steps.reversed() {
                switch step.timeUnit {
                case .minute:
                    currentTime = currentTime.withAdded(minutes: -step.timeValue)
                case .hour:
                    currentTime = currentTime.withAdded(hours: -step.timeValue)
                case .day:
                    currentTime = currentTime.withAdded(days: -step.timeValue)
                }
                if let index = steps.firstIndex(where: { $0 == step }) {
                    steps[index].date = currentTime
                }
            }
        }
    }
}