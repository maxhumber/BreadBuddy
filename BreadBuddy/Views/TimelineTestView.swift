
import SwiftUI

struct TimelineTestView: View {
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            Text("\(context.date)")
        }
    }
}

struct TimelineTestView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineTestView()
    }
}
