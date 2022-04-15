import BBKit
import SwiftUI

struct Display: View {
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
            Text.scaffold("12:59 am")
            Text(step.timeStartString)
        }
        .font(.body.bold())
    }
    
    private var activity: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(step.description)
                .font(.body)
            Text(step.durationString)
                .font(.caption.italic())
                .opacity(step.timeValue == 0 ? 0 : 1)
        }
    }
}

struct DisplayRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .empty)
    }
}
