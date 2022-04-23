import SwiftUI

public struct FancyButtonStyle: ButtonStyle {
    var cornerRadius: Double
    var offset: (x: Double, y: Double)
    var outline: Color?
    var fill: Color?
    
    public init(cornerRadius: Double = 4, offset: (x: Double, y: Double) = (3, -3), outline: Color? = nil, fill: Color? = nil) {
        self.cornerRadius = cornerRadius
        self.offset = offset
        self.outline = outline
        self.fill = fill
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background {
                ZStack {
                    backgroundRect
                    foregroundRect
                }
                .foregroundColor(outline ?? .blue)
            }
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
    
    private var foregroundRect: some View {
        roundedRect
            .strokeBorder()
    }
    
    private var backgroundRect: some View {
        roundedRect
            .foregroundColor(fill ?? .blue.opacity(0.25))
            .offset(x: offset.x, y: offset.y)
            .mask(maskingRect)
    }
    
    private var maskingRect: some View {
        ZStack {
            roundedRect
                .offset(x: offset.x, y: offset.y)
                .fill(.white)
            roundedRect
                .foregroundColor(.black)
        }
        .compositingGroup()
        .luminanceToAlpha()
    }
    
    private var roundedRect: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius)
    }
}

struct XButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 15) {
            Button {
                print("Nothing")
            } label: {
                Text("Hey")
                    .padding()
            }
            .buttonStyle(FancyButtonStyle(outline: .red, fill: .red.opacity(0.25)))
            Button {
                print("Nothing")
            } label: {
                Text("Hey")
                    .padding()
            }
            .buttonStyle(FancyButtonStyle())
        }
        .padding()
    }
}
