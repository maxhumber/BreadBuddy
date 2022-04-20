import SwiftUI

extension Color {
    static let background = Color("background")
    static let accent1 = Color("accent1")
    static let accent2 = Color("accent2")
    static let text1 = Color("text1")
    static let text2 = Color("text2")
}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
            .preferredColorScheme(.light)
        Preview()
            .preferredColorScheme(.dark)
    }
    
    struct Preview: View {
        var body: some View {
            ZStack {
                background
                content
            }
        }
        
        private var background: some View {
            Color.background
                .edgesIgnoringSafeArea(.all)
        }
        
        private var content: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("Section Title")
                    .font(.title3)
                    .foregroundColor(.accent1)
                Text("Lorem Ipsum 4:30 pm")
                    .font(.body)
                    .foregroundColor(.text1)
                Text("Wednesday Subtitle")
                    .font(.caption)
                    .foregroundColor(.text2)
                HStack(alignment: .bottom, spacing: 20) {
                    VStack(spacing: 10) {
                        Image(systemName: "chevron.left")
                            .font(.body)
                        Text("Label")
                            .font(.caption)
                    }
                    .foregroundColor(.accent1)
                    VStack(spacing: 10) {
                        Image(systemName: "trash")
                            .font(.body)
                        Text("Label")
                            .font(.caption)
                    }
                    .foregroundColor(.accent2)
                }
            }
            .padding()
        }
    }
}
