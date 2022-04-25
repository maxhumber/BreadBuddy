import SwiftUI

extension View {
    public func dismissingGesture(tolerance: Double = 24, action: @escaping () -> ()) -> some View {
        gesture(DragGesture()
            .onEnded { value in
                let direction = value.detectDirection(tolerance)
                if direction == .left {
                    action()
                }
            }
        )
    }
}

extension DragGesture.Value {
    func detectDirection(_ tolerance: Double = 24) -> Direction? {
        if startLocation.x < location.x - tolerance { return .left }
        if startLocation.x > location.x + tolerance { return .right }
        if startLocation.y > location.y + tolerance { return .up }
        if startLocation.y < location.y - tolerance { return .down }
        return nil
    }
    
    enum Direction {
        case left
        case right
        case up
        case down
    }
}

struct DismissingGesture_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        var body: some View {
            NavigationView {
                NavigationLink {
                    Destination()
                } label: {
                    Text("Go")
                }
            }
        }
    }
    
    struct Destination: View {
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all)
                Text("Nothing")
            }
            .dismissingGesture {
                dismiss()
            }
            .navigationBarHidden(true)
        }
    }
}
