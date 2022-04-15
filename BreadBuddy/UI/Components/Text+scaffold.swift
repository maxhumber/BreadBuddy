import SwiftUI

extension Text {
    static func scaffold(_ text: String) -> some View {
        Text(text).opacity(0)
    }
    
    static func scaffold(characters: Int) -> some View {
        Text(String.init(repeating: "X", count: characters)).opacity(0)
    }
}
