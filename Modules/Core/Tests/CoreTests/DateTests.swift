@testable import Core
import XCTest

final class DateTests: XCTestCase {
    func testSimpleToday() {
        let date = Date()
        XCTAssertEqual(date.simple, "Today")
    }
    
    func testSimpleYesterday() {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        XCTAssertEqual(date.simple, "Yesterday")
    }
    
    func testSimpleTomorrow() {
        let date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        XCTAssertEqual(date.simple, "Tomorrow")
    }
    
    func testSimpleDayOfWeekLabel() {
        let start = Date("2022-04-20")
        let date = Calendar.current.date(byAdding: .day, value: 2, to: start)!
        XCTAssertEqual(date.simple, "Friday")
    }
    
    func testSimpleDOWLimit() {
        let start = Date("2022-04-20")
        let date = Calendar.current.date(byAdding: .day, value: 6, to: start)!
        XCTAssertEqual(date.simple, "Tuesday")
    }
    
    func testSimpleIso8601Forward() {
        let start = Date("2022-04-20")
        let date = Calendar.current.date(byAdding: .day, value: 7, to: start)!
        XCTAssertEqual(date.simple, "2022-04-27")
    }
    
    func testSimpleIso8601Backward() {
        let start = Date("2022-04-20")
        let date = Calendar.current.date(byAdding: .day, value: -2, to: start)!
        XCTAssertEqual(date.simple, "2022-04-18")
    }
}
