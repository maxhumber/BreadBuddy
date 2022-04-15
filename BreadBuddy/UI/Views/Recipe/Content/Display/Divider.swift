import SwiftUI

struct Divider: View {
    var day: Day
    
    var body: some View {
        HStack(spacing: 10) {
            line
            label
            line
        }
        .foregroundColor(.gray)
        .padding(.horizontal)
    }
    
    #warning("make this better")
    private var label: some View {
        Text(day.date.weekday())
            .font(.caption)
    }
    
    private var line: some View {
        Rectangle()
            .frame(height: 1)
            .opacity(0.5)
    }
}

struct Divider_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(.preview, mode: .display, database: .empty())
    }
}
