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
        }
        
        private var timeStart: some View {
            ZStack(alignment: .trailing) {
                TextScaffold("XXXXXXX")
                Text(step.clocktimeStart)
            }
            .font(.bodyMatter)
        }
        
        private var activity: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(step.description)
                    .font(.bodyMatter)
                Text(step.duration)
                    .font(.captionMatter)
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
