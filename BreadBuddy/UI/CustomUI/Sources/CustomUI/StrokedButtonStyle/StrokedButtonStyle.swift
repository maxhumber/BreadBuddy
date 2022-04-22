import SwiftUI

public struct StrokedButtonStyle: ButtonStyle {
    private let cornerRadius: Double
    
    public init(cornerRadius: Double = 5) {
        self.cornerRadius = cornerRadius
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder()
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}

struct StrokedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button {
            print("Nothing")
        } label: {
            Image(systemName: "checkmark")
                .padding()
        }
        .buttonStyle(StrokedButtonStyle())
        .padding()
    }
}
