import Combine
import Foundation

extension ContentView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var date: Date
        @Published var steps: [Step]
        
        init(date: Date? = nil, steps: [Step] = [Step]()) {
            let nextSunday = Date().next(.sunday)?.withAdded(hours: 15)
            self.date = date ?? nextSunday ?? Date()
            self.steps = steps
        }
        
        func add() {
//            let label = String(UUID().uuidString.prefix(4))
            let step = Step(label: "", timeValue: 30, timeUnit: .minute)
            steps.append(step)
            refresh()
        }
        
        func refresh() {
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
