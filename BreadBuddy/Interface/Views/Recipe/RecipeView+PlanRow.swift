import Core
import Sugar
import SwiftUI

extension RecipeView {
    struct PlanRow: View {
        private var step: Step
        
        init(_ step: Step) {
            self.step = step
        }
        
        var body: some View {
            HStack(alignment: .top, spacing: 20) {
                timeStart
                activity
                Spacer()
            }
            .contentShape(Rectangle())
        }
        
        private var timeStart: some View {
            ZStack(alignment: .topTrailing) {
                TextScaffold("XXXXXXX")
                Text(step.clocktimeStart)
            }
            .font(.matter(emphasis: .bold))
            .foregroundColor(isPast ? .text2.opacity(0.35) : .text1)
        }
        
        private var activity: some View {
            VStack(alignment: .leading, spacing: 6) {
                Text(step.description)
                    .font(.matter())
                    .foregroundColor(isPast ? .text2.opacity(0.4) : .text1)
                Text(step.duration)
                    .font(.matter(.caption2, emphasis: .italic))
                    .foregroundColor(isPast ? .text2.opacity(0.4) : .text2)
            }
        }
        
        private var isPast: Bool {
            guard let timeStart = step.timeStart else { return false }
            return timeStart < Date().withAdded(minutes: -1)
        }
    }
}

struct PlanRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .plan, database: .preview)
    }
}
