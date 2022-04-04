import Combine
import Foundation

extension ContentView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var time = Date().addingTimeInterval(24)
        @Published var steps = [
            Step(label: "Step 1", timeValue: 1, timeUnit: .hour),
            Step(label: "Step 2", timeValue: 2.5, timeUnit: .hour),
            Step(label: "Step 3", timeValue: 12.5, timeUnit: .hour),
            Step(label: "Step 4", timeValue: 0.5, timeUnit: .hour),
            Step(label: "Step 5", timeValue: 0.5, timeUnit: .hour),
        ]
        
        func add() {
            let step = Step(label: "Step 6", timeValue: 0.5)
            steps.append(step)
        }
        
        func refresh() {
            var currentTime = time
            for step in steps.reversed() {
                #warning("handle non-hours")
                let hours = step.timeValue * 60 * 60
                currentTime = currentTime.addingTimeInterval(-hours)
                if let index = steps.firstIndex(where: { $0 == step }) {
                    steps[index].date = currentTime
                }
            }
        }
    }
}
