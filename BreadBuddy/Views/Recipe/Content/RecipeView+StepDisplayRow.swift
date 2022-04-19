import Core
import CustomUI
import SwiftUI

extension RecipeView {
    struct StepDisplayRow: View {
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
        }
        
        private var timeStart: some View {
            ZStack(alignment: .trailing) {
                TextScaffold("12:59 am")
                Text(step.clocktimeStart)
            }
            .font(.body.bold())
        }
        
        private var activity: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(step.description)
                    .font(.body)
                Text(step.duration)
                    .font(.caption.italic())
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct DisplayRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .preview)
    }
}
