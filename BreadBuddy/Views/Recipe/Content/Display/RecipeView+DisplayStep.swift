import Core
import CustomUI
import SwiftUI

extension RecipeView {
    struct DisplayStep: View {
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
        }
        
        private var timeStart: some View {
            ZStack(alignment: .topTrailing) {
                TextScaffold("XXXXXXX")
                Text(step.clocktimeStart)
            }
            .font(.matter(emphasis: .bold))
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
    }
}

struct DisplayRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .preview)
    }
}
