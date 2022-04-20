import SwiftUI

extension Font {
    static func matter(_ size: MatterSize = .body, emphasis: MatterEmphasis = .regular) -> Font {
        switch size {
        case .title:
            return .custom("Matter-\(emphasis.rawValue)", size: 21, relativeTo: .title3)
        case .body:
            return .custom("Matter-\(emphasis.rawValue)", size: 18, relativeTo: .body)
        case .caption:
            return .custom("Matter-\(emphasis.rawValue)", size: 15, relativeTo: .caption)
        case .caption2:
            return .custom("Matter-\(emphasis.rawValue)", size: 13, relativeTo: .caption2)
        }
    }
    
    enum MatterSize {
        case title
        case body
        case caption
        case caption2
    }
    
    enum MatterEmphasis: String {
        case regular = "Regular"
        case italic = "RegularItalic"
        case bold = "SemiBold"
        case boldItalic = "SemiBoldItalic"
    }
}

struct Matter_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        var body: some View {
            VStack(spacing: 20) {
                Text("This is a title")
                    .font(.matter(.title))
                Text("4:30 pm")
                    .font(.custom("Matter-SemiBold", size: 18, relativeTo: .body))
                    .font(.matter(.body, emphasis: .bold))
                Text("This is some body")
                    .font(.matter(.body))
                Text("This is a caption")
                    .font(.matter(.caption))
                Text("This is an italic caption")
                    .font(.matter(.caption, emphasis: .italic))
                Text("This is a small caption")
                    .font(.matter(.caption2))
                Text("This is an italic small caption")
                    .font(.matter(.caption2, emphasis: .italic))
            }
        }
    }
}
