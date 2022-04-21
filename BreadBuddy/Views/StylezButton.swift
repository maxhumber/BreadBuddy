import SwiftUI

struct StylezButton: View {
    var cornerRadius: Double = 8
    var offset: Double = 4
    
    var body: some View {
        HStack {
            Image(systemName: "circle")
            Text("Hey")
                .font(.matter(.caption))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder()
            }
        )
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .opacity(0.25)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder()
            }
            .offset(x: offset, y: -offset)
        )
        .foregroundColor(.accent1)
        .padding()
    }
}

struct StylezButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StylezButton()
    }
}
