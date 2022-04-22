import SwiftUI

struct StylezButton: View {
    var cornerRadius: Double = 8
    var offset: Double = 4
    
    var body: some View {
        Text("Hey")
            .padding()
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder()
                    .foregroundColor(.blue)
                    .mask {
                        ZStack {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(.white)
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .foregroundColor(.black)
                                .offset(x: -10, y: 10)
                        }
                        .compositingGroup()
                        .luminanceToAlpha()
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder()
                            .foregroundColor(.red)
                            .offset(x: -10, y: 10)
                    }
            }


//            .clipShape(

//            )

//        HStack {
//            Image(systemName: "circle")
//            Text("Hey")
//                .font(.matter(.caption))
//        }
//        .frame(maxWidth: .infinity)
//        .padding()
//        .background(
//            ZStack {
//                RoundedRectangle(cornerRadius: cornerRadius)
//                    .foregroundColor(.white)
//                RoundedRectangle(cornerRadius: cornerRadius)
//                    .strokeBorder()
//            }
//        )
//        .background(
//            ZStack {
//                RoundedRectangle(cornerRadius: cornerRadius)
//                    .opacity(0.25)
//                RoundedRectangle(cornerRadius: cornerRadius)
//                    .strokeBorder()
//            }
//            .offset(x: offset, y: -offset)
//        )
//        .foregroundColor(.accent1)
//        .padding()
    }
}

struct Demo: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color.red)
            .mask {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 50, height: 50)
                    Image(systemName: "play.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color.black)
                }
                .compositingGroup()
                .luminanceToAlpha()
            }
    }
}

struct Stylez2ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StylezButton()
    }
}
