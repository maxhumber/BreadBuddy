import SwiftUI

public struct FancyButtonStyle: ButtonStyle {
    var cornerRadius: Double
    var offset: CGSize
    var outline: Color?
    var fill: Color?
    
    public init(cornerRadius: Double = 4, offset: CGSize = CGSize(width: 3, height: -3), outline: Color? = nil, fill: Color? = nil) {
        self.cornerRadius = cornerRadius
        self.offset = offset
        self.outline = outline
        self.fill = fill
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(FancyBox(cornerRadius: cornerRadius, offset: offset, outline: outline, fill: fill))
    }
}

public struct FancyBox: ViewModifier {
    var cornerRadius: CGFloat
    var offset: CGSize
    var outline: Color?
    var fill: Color?
    
    public init(cornerRadius: Double = 4, offset: CGSize = CGSize(width: 3, height: -3), outline: Color? = nil, fill: Color? = nil) {
        self.cornerRadius = cornerRadius
        self.offset = offset
        self.outline = outline
        self.fill = fill
    }
    
    public func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    backgroundRect
                    foregroundRect
                }
                .foregroundColor(outline ?? .blue)
            }
    }
    
    private var foregroundRect: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder()
    }
    
    private var backgroundRect: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundColor(fill ?? .blue.opacity(0.25))
            .offset(offset)
            .mask(maskingRect)
    }
    
    private var maskingRect: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .offset(offset)
                .fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(.black)
        }
        .compositingGroup()
        .luminanceToAlpha()
    }
}

struct XButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 15) {
            Text("AAA")
                .padding()
                .modifier(FancyBox())
            Button {
                print("Nothing")
            } label: {
                Text("BBB")
                    .padding()
            }
            .buttonStyle(FancyButtonStyle(outline: .red, fill: .red.opacity(0.25)))
            Button {
                print("Nothing")
            } label: {
                Text("CCC")
                    .padding()
            }
            .buttonStyle(FancyButtonStyle())
        }
        .padding()
    }
}
