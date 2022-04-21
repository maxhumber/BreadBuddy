import Foundation

extension Date {    
    public var clocktime: String {
        Formatter.clock.string(from: self).lowercased()
    }
}
