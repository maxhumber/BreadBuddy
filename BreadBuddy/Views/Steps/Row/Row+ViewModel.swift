import Combine
import Foundation

extension Row {
    final class ViewModel: ObservableObject {
        @Published var step: Step
        
        init(_ step: Step) {
            self.step = step
        }
        
        var timeInputFieldOpacity: Double {
            step.timeInMinutes == 0 ? 0.5 : 1
        }
        
        var timeUnitLabel: String {
            let unitString = step.timeUnitPreferrence.rawValue.capitalized
            if step.timeInMinutes == 1 {
                return String(unitString.dropLast())
            } else {
                return unitString
            }
        }
        
        private var timeStart: Date {
            step.timeStart ?? Date()
        }
        
        var timeString: String {
            timeStart.time()
        }
        
        var weekdayString: String {
            timeStart.weekday()
        }
        
        var startTimeOpacity: Double {
            step.timeStart == nil ? 0 : 1
        }
        
        func save() {
            
        }
    }
}
