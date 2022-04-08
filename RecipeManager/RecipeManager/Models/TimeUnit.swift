import Foundation
import GRDB

enum TimeUnit: String {
    case minutes = "minutes"
    case hours = "hours"
    case days = "days"
}

extension TimeUnit: Codable {}

extension TimeUnit: CaseIterable {}

extension TimeUnit: DatabaseValueConvertible {}
