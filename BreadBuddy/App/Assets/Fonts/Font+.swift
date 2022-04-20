import SwiftUI

extension Font {
    static var titleMatter: Font {
        .custom("Matter-Regular", size: 28, relativeTo: .title)
    }
    
    static var title2Matter: Font {
        .custom("Matter-Regular", size: 22, relativeTo: .title2)
    }
    
    static var title3Matter: Font {
        .custom("Matter-Regular", size: 20, relativeTo: .title3)
    }
    
    static var bodyMatter: Font {
        .custom("Matter-Regular", size: 17, relativeTo: .body)
    }
    
    static var captionMatter: Font {
        .custom("Matter-Regular", size: 14, relativeTo: .caption)
    }
    
    static var titleReckless: Font {
        .custom("RecklessNeue-Medium", size: 28, relativeTo: .title)
    }
    
    static var title2Reckless: Font {
        .custom("RecklessNeue-Medium", size: 22, relativeTo: .title2)
    }
    
    static var title3Reckless: Font {
        .custom("RecklessNeue-Medium", size: 20, relativeTo: .title3)
    }
    
    static var bodyReckless: Font {
        .custom("RecklessNeue-Medium", size: 17, relativeTo: .body)
    }
    
    static var captionReckless: Font {
        .custom("RecklessNeue-Medium", size: 14, relativeTo: .caption)
    }
}

struct Matter_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    struct Preview: View {
        var body: some View {
            VStack {
                HStack(alignment: .bottom, spacing: 20) {
                    Text("Friday")
                        .font(.title)
                    Text("Friday")
                        .font(.titleMatter)
                    Text("Friday")
                        .font(.titleReckless)
                }
                HStack(alignment: .bottom, spacing: 20) {
                    Text("Sunday")
                        .font(.title2)
                    Text("Sunday")
                        .font(.title2Matter)
                    Text("Sunday")
                        .font(.title2Reckless)
                }
                HStack(alignment: .bottom, spacing: 20) {
                    Text("Saturday")
                        .font(.title3)
                    Text("Saturday")
                        .font(.custom("Matter-Regular", size: 20, relativeTo: .title3))
                    Text("Saturday")
                        .font(.custom("RecklessNeue-Medium", size: 20, relativeTo: .title3))
                }
                HStack(alignment: .bottom, spacing: 20) {
                    Text("Wednesday")
                        .font(.body)
                    Text("Wednesday")
                        .font(.custom("Matter-Regular", size: 17, relativeTo: .body))
                    Text("Wednesday")
                        .font(.custom("RecklessNeue-Medium", size: 17, relativeTo: .body))
                }
                HStack(alignment: .bottom, spacing: 20) {
                    Text("Thursday")
                        .font(.caption)
                    Text("Thursday")
                        .font(.custom("Matter-Regular", size: 14, relativeTo: .caption))
                    Text("Thursday")
                        .font(.custom("RecklessNeue-Medium", size: 14, relativeTo: .caption))
                }
            }
        }
    }
}
