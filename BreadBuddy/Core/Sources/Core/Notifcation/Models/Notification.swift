import Foundation

public struct Notification {
    public var id: String = UUID().uuidString
    public var title: String
    public var subtitle: String?
    public var time: Date
    
    public init(id: String = UUID().uuidString, title: String, subtitle: String? = nil, time: Date) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.time = time
    }
}
