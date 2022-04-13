import Foundation
import GRDB

enum TimeUnit: String {
    case minutes = "mins"
    case hours = "hrs"
    case days = "days"
}

extension TimeUnit: Codable {}

extension TimeUnit: CaseIterable {}

extension TimeUnit: DatabaseValueConvertible {}

extension TimeUnit: Identifiable {
    var id: String {
        rawValue
    }
}
