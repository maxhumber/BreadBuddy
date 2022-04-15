import SwiftUI

struct DisplayRow: View {
    var step: Step
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            time
            activity
            Spacer()
        }
    }
    
    private var time: some View {
        ZStack(alignment: .trailing) {
            SkeleText("12:59 am")
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
        RecipeView(recipe: .preview, database: .empty())
    }
}
