import SwiftUI

public struct StealthList<Content: View>: View {
    var spacing: Double
    var content: Content
    
    public init(spacing: Double = 0, @ViewBuilder content: () -> Content) {
        UITableView.appearance().backgroundColor = UIColor(.clear)
        UITableViewCell.appearance().selectionStyle = .none
        self.spacing = spacing
        self.content = content()
    }
    
    public var body: some View {
        List {
            content
                .padding(.horizontal)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: spacing/2, leading: 0, bottom: spacing/2, trailing: 0))
                .listRowBackground(Color.clear)
        }
        .listStyle(InsetListStyle())
    }
}

struct StealthList_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        private var things = ["Cat", "Dog", "Seal"]
        
        var body: some View {
            StealthList {
                ForEach(things, id: \.self) { thing in
                    Text(thing)
                }
            }
        }
    }
}
