import Foundation
import GRDB

enum Priority: String {
    case low
    case medium
    case high
}

extension Priority: Codable, CaseIterable {}

extension Priority: DatabaseValueConvertible {}
