import SwiftUI

extension View {
    func dismissKeyboard() -> some View {
        self
            .onTapGesture {
                UIApplication.shared.sendResignAction()
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { gesture in
                        if gesture.translation.height > 0 {
                            UIApplication.shared.sendResignAction()
                        }
                    }
            )
    }
}
