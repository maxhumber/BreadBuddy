import Core
import CustomUI
import SwiftUI

extension RecipeView {
    struct PlanStep: View {
        var step: Step
        
        init(_ step: Step) {
            self.step = step
        }
        
        var body: some View {
            HStack(alignment: .top, spacing: 20) {
                timeStart
                activity
                Spacer()
            }
            .foregroundColor(.text1)
            .contentShape(Rectangle())
        }
        
        private var timeStart: some View {
            ZStack(alignment: .topTrailing) {
                TextScaffold("XXXXXXX")
                Text(step.clocktimeStart)
            }
            .font(.matter(emphasis: .bold))
            .if(isPast) { $0.foregroundColor(.text2) }
        }
        
        private var activity: some View {
            VStack(alignment: .leading, spacing: 6) {
                Text(step.description)
                    .font(.matter())
                Text(step.duration)
                    .font(.matter(.caption2, emphasis: .italic))
                    .foregroundColor(.text2)
            }
        }
        
        private var isPast: Bool {
            guard let timeStart = step.timeStart else { return false }
            return timeStart < Date().withAdded(minutes: -1)
        }
    }
}

struct DisplayRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .plan, database: .preview)
    }
}
