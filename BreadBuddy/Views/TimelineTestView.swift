import SwiftUI

struct TimelineTestView: View {
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            HStack {
                Image(systemName: "circle")
                Text("Hey")
            }
            .padding()
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.white)
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder()
                }
            )
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .opacity(0.25)
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder()
                }
                .offset(x: 5, y: -5)
            )
            .foregroundColor(.red)
        }
    }
}

struct TimelineTestView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineTestView()
    }
}
