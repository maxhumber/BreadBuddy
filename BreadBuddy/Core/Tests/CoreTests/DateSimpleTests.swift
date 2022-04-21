@testable import Core
import XCTest

final class DateSimpleTests: XCTestCase {
    func testSimpleToday() {
        XCTAssertEqual(Date.now.simple, "Today")
    }
    
    func testSimpleYesterday() {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: .now)!
        XCTAssertEqual(date.simple, "Yesterday")
    }
    
    func testSimpleTomorrow() {
        let date = Calendar.current.date(byAdding: .day, value: 1, to: .now)!
        XCTAssertEqual(date.simple, "Tomorrow")
    }
    
    func testSimpleDayOfWeekLabel() {
        let date = Calendar.current.date(byAdding: .day, value: 2, to: .now)!
        XCTAssert(date.simple.contains("day"))
    }
    
    func testSimpleDOWLimit() {
        let date = Calendar.current.date(byAdding: .day, value: 6, to: .now)!
        XCTAssert(date.simple.contains("day"))
    }
    
    func testSimpleIso8601Forward() {
        let date = Calendar.current.date(byAdding: .day, value: 7, to: .now)!
        XCTAssert(!date.simple.contains("day"))
    }
    
    func testSimpleIso8601Backward() {
        let date = Calendar.current.date(byAdding: .day, value: -2, to: .now)!
        XCTAssert(date.simple.contains("-"))
    }
}
