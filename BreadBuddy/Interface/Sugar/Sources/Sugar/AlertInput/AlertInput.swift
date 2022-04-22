import SwiftUI

public struct AlertInput {
    public var title: String
    public var message: String?
    public var placeholder: String
    @Binding public var text: String?
    
    public init(title: String, message: String? = nil, placeholder: String = "", text: Binding<String?>) {
        self.title = title
        self.message = message
        self.placeholder = placeholder
        self._text = text
    }
}
